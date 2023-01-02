#!/usr/bin/env bash

function create_namespace_secret_catalog_source() {

echo "----------------------------------------------------------------------"
echo "1. Installing - Namespace, OperatorGroup, secrets, ServiceAccount and CatalogSource started"
echo "----------------------------------------------------------------------"

echo "-----------------------------------"
echo "1.1. Create namespace cp4waiops ..."
echo "-----------------------------------"
oc create namespace $NAMESPACE

sleep 3


echo "-----------------------------------"
echo "1.2. Create OperatorGroup ..."
echo "-----------------------------------"
cat << EOF | oc apply -f -
apiVersion: operators.coreos.com/v1
kind: OperatorGroup
metadata:
  name: cp4waiops-operator-group
  namespace: $NAMESPACE
spec:
  targetNamespaces:
    - $NAMESPACE
EOF

sleep 3

### Create secrets
echo "-----------------------------------"
echo "1.3. Create secrets"
echo "-----------------------------------"

oc create secret docker-registry ibm-entitlement-key \
    --docker-username=cp\
    --docker-password=$ENTITLEMENT_KEY \
    --docker-server=cp.icr.io \
    --namespace=$NAMESPACE

sleep 3


### Ensure external traffic access to AI Manager
echo "-----------------------------------"
echo "1.4. Ensure external traffic access to AI Manager"
echo "-----------------------------------"
if [ $(oc get ingresscontroller default -n openshift-ingress-operator -o jsonpath='{.status.endpointPublishingStrategy.type}') = "HostNetwork" ]; then oc patch namespace default --type=json -p '[{"op":"add","path":"/metadata/labels","value":{"network.openshift.io/policy-group":"ingress"}}]'; fi


### Create CatalogSource
echo "-----------------------------------"
echo "1.6. Create CatalogSource"
echo "-----------------------------------"
cat << EOF | oc apply -f -
apiVersion: operators.coreos.com/v1alpha1
kind: CatalogSource
metadata:
  name: ibm-operator-catalog
  namespace: openshift-marketplace
spec:
  displayName: ibm-operator-catalog
  publisher: IBM Content
  sourceType: grpc
  # updateStrategy:
  #   registryPoll:
  #     interval: 45m
  image: icr.io/cpopen/ibm-operator-catalog:latest
EOF

sleep 15

echo "Process completed .... "

}

