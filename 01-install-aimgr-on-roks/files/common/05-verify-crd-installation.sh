#!/usr/bin/env bash

function verify_crd_installation() {

echo "----------------------------------------------------------------------"
echo "5. Verify CRD Installation ..."
echo "----------------------------------------------------------------------"
echo "Executing the below command ...."
echo "oc get installations.orchestrator.aiops.ibm.com ibm-cp-watson-aiops -n $NAMESPACE | grep Running"
echo "The output should be like this...."
echo "ibm-ia-installer   Running   ibmc-file-gold-gid   4m53s"

export GLOBAL_VERIFY_STATUS=false

RESOURCE_COUNT=0
RESOURCE_FOUND=false
LOOP_COUNT=0
MAX_LOOP_COUNT=180

while [[ ${RESOURCE_FOUND} == "false" && $LOOP_COUNT -lt $MAX_LOOP_COUNT ]]; do
    LOOP_COUNT=$((LOOP_COUNT+1))
    echo "Trying for $LOOP_COUNT / $MAX_LOOP_COUNT."

    RESOURCE_COUNT=$(oc get installations.orchestrator.aiops.ibm.com ibm-cp-watson-aiops -n ${NAMESPACE} | grep -c Running)

    if [[ $RESOURCE_COUNT -gt 0 ]]; 
    then
        RESOURCE_FOUND=true
    else
        RESOURCE_FOUND=false
        sleep 5
    fi
done

if [[ $RESOURCE_FOUND == "true" ]]; 
then
    echo "Resource installations.orchestrator.aiops.ibm.com ibm-cp-watson-aiops is found in Running state"
    export GLOBAL_VERIFY_STATUS=true
else
    echo "Resource installations.orchestrator.aiops.ibm.com ibm-cp-watson-aiops is NOT found in Running state"
    export GLOBAL_VERIFY_STATUS=false
fi

echo "Status : ${GLOBAL_VERIFY_STATUS} "

echo "Process completed .... "


}