#!/usr/bin/env bash

function configure_signed_certificates_for_NGINX () {

echo "----------------------------------------------------------------------"
echo "7. Configure signed certificates for NGINX  ......"
echo "----------------------------------------------------------------------"

echo "-----------------------------------"
echo "7.1. Delete your AutomationUIConfig instance and quickly re-create it before the Installation operator automatically re-creates it"
echo "-----------------------------------"

AUTO_UI_INSTANCE=$(oc get AutomationUIConfig -n $NAMESPACE --no-headers -o custom-columns=":metadata.name")
ingress_pod=$(oc get secrets -n openshift-ingress | grep tls | grep -v router-metrics-certs-default | awk '{print $1}')
oc get secret -n openshift-ingress -o 'go-template={{index .data "tls.crt"}}' ${ingress_pod} | base64 -d > cert.crt
oc get secret -n openshift-ingress -o 'go-template={{index .data "tls.key"}}' ${ingress_pod} | base64 -d > cert.key
oc get secret -n $NAMESPACE external-tls-secret -o yaml > external-tls-secret.yaml
oc delete secret -n $NAMESPACE external-tls-secret
sleep 15
oc create secret generic -n $NAMESPACE external-tls-secret --from-file=cert.crt=cert.crt --from-file=cert.key=cert.key -o yaml | oc apply -f -

oc patch AutomationUIConfig $AUTO_UI_INSTANCE -n $NAMESPACE \
    --type merge \
    --patch '{"spec": {"tls": {"caSecret": {"key":"ca.crt", "secretName": "external-tls-secret"}, "certificateSecret": { "secretName": "external-tls-secret"}}}}'

# Recreate nginx. The new NGINX pods get the new certificate. It takes a few minutes for the NGINX pods to come back up.
oc delete pod $(oc get po -n $NAMESPACE |grep ibm-nginx |awk '{print$1}') -n $NAMESPACE

# Remove temp files
rm cert.crt
rm cert.key
# rm ca.crt
rm external-tls-secret.yaml

}