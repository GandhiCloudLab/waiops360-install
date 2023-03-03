#!/usr/bin/env bash

function install_preinstall() {

echo "-----------------------------------"
echo "0. Create a secret for your entitlement key ..."
echo "-----------------------------------"

oc create secret docker-registry cp.icr.io \
    --docker-username=cp\
    --docker-password=$ENTITLEMENT_KEY \
    --docker-server=cp.icr.io \
    --namespace=$NAMESPACE

oc create secret docker-registry ibm-entitlement-key-secret \
    --docker-username=cp\
    --docker-password=$ENTITLEMENT_KEY \
    --docker-server=cp.icr.io \
    --namespace=$NAMESPACE

echo "Process completed .... "

echo "-----------------------------------"
echo "0. Create a secret for your entitlement key ..."
echo "-----------------------------------"

cat <<EOF | oc apply -f -
apiVersion: v1
kind: ServiceAccount
metadata:
  name: sevone-probe-service-account
  namespace: $NAMESPACE
  labels:
    managedByUser: 'true'
imagePullSecrets:
  - name: cp.icr.io
EOF


#         - $(KEYSTORE_PASS)
#   serviceAccountName: sevone-probe-mb-webhook-sa
#   imagePullSecrets:
#     - name: sevone-probe-mb-webhook-sa-dockercfg-xvhsc

}

