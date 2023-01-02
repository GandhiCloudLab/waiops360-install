#!/usr/bin/env bash

function create_subscription() {

### Install  AI Manager operator (Subscription)
echo "----------------------------------------------------------------------"
echo "2. Install AI Manager operator (Subscription : ibm-aiops-orchestrator)"
echo "----------------------------------------------------------------------"

cat << EOF | oc apply -f -
apiVersion: operators.coreos.com/v1alpha1
kind: Subscription
metadata:
  name: ibm-aiops-orchestrator
  namespace: $NAMESPACE
spec:
  channel: $SUBSCRIPTION_CHANNEL
  installPlanApproval: Automatic
  name: ibm-aiops-orchestrator
  source: ibm-operator-catalog
  sourceNamespace: openshift-marketplace
EOF

sleep 5

echo "Process completed .... "

}
