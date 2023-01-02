#!/usr/bin/env bash

function verify_pods_count () {

echo "----------------------------------------------------------------------"
echo " 6. Verify Pods Count and Status in ($NAMESPACE) Namespace"
echo "----------------------------------------------------------------------"

GLOBAL_POD_VERIFY_STATUS=false

POD_COUNT=0
MIN_POD_COUNT=110
MAX_WAIT_MINUTES=120
LOOP_COUNT=0

echo "-----------------------------------"
echo " 6.1 Pods Count "
echo "-----------------------------------"

POD_COUNT=$(oc get pods -n $NAMESPACE | wc -l ) 
while [[ $POD_COUNT -lt $MIN_POD_COUNT ]] && [[ $LOOP_COUNT -lt $MAX_WAIT_MINUTES ]]; do
  sleep 60
  POD_COUNT=$(oc get pods -n $NAMESPACE | wc -l ) 
  echo "Pods Count in $LOOP_COUNT minutes : $POD_COUNT"
  LOOP_COUNT=$((LOOP_COUNT + 1))
done

if [[ $POD_COUNT -gt $MIN_POD_COUNT ]]; then
  echo "Pods counts in $NAMESPACE namespace are OK and it is more than $MIN_POD_COUNT"; 
  GLOBAL_POD_VERIFY_STATUS=true
else
  echo "Timed out waiting for PODs in ${NAMESPACE}"
  echo "Only $POD_COUNT pods are created in $NAMESPACE namespace. It should be more than  $MIN_POD_COUNT"; 
  GLOBAL_POD_VERIFY_STATUS=false
fi

echo "-----------------------------------"
echo " 6.2 Pods with issues (Failed / Error / CrossLoopBackOff / Pending)"
echo "-----------------------------------"

POD_COUNT=$(oc get pods -n $NAMESPACE | grep 'Failed\|Error\|CrossLoopBackOff\\|Pending' | wc -l ) 
if [[ $POD_COUNT -gt 0 ]]; then
  echo "Pods Count with Issues : $POD_COUNT"
  echo "Here are the pods with issues......"
  oc get pods | grep 'Failed\|Error\|CrossLoopBackOff\\|Pending'

else
  echo "Pods Count with Issues : $POD_COUNT"
fi

echo "-----------------------------------"
echo " 6.3 Pods are in running state but with issues"
echo "-----------------------------------"
POD_COUNT=$(oc get pods -n $NAMESPACE | grep Running |  grep '0\\' | wc -l ) 
if [[ $POD_COUNT -gt 0 ]]; then
  echo "Pods Count in Running State with issues : $POD_COUNT"
  echo "Here are the pods with issues......"
  oc get pods -n $NAMESPACE | grep 'Running' |  grep '0\\'
else
  echo "Pods Count in Running State with issues : $POD_COUNT"
fi

}