#!/usr/bin/env bash

function create_subscription() {

### Install IBM Netcool Operations Insight Event Integrations operator (Subscription)
echo "----------------------------------------------------------------------"
echo "2. Install IBM Netcool Operations Insight Event Integrations operator (Subscription : ibm-aiops-orchestrator)"
echo "----------------------------------------------------------------------"

cat << EOF | oc apply -f -
apiVersion: operators.coreos.com/v1alpha1
kind: Subscription
metadata:
  name: netcool-integrations-operator
  namespace: $NAMESPACE
spec:
  channel: $SUBSCRIPTION_CHANNEL
  installPlanApproval: Automatic
  name: netcool-integrations-operator
  source: ibm-operator-catalog
  sourceNamespace: openshift-marketplace
  startingCSV: $STARTING_CSV

EOF

sleep 5

echo "Process completed .... "

}