#!/usr/bin/env bash

function create_crd_installation () {

echo "----------------------------------------------------------------------"
echo "4. Install CRD Installation (ibm-cp-watson-aiops) ..."
echo "----------------------------------------------------------------------"

cat << EOF | oc apply -f -
apiVersion: orchestrator.aiops.ibm.com/v1alpha1
kind: Installation
metadata:
  name: ibm-cp-watson-aiops
  namespace: $NAMESPACE
spec:
  imagePullSecret: ibm-entitlement-key
  license:
    accept: true
  pakModules:
    - name: aiopsFoundation
      enabled: true
      # - name: ibm-management-kong
      #   enable: true
      #   spec:
      #     kong:
      #       metrics:
      #         enabled: true
    - name: applicationManager
      enabled: true
    - name: aiManager
      enabled: true
    - name: connection
      enabled: false


  size: small
  storageClass: $AI_MANAGER_STORAGE_CLASS
  storageClassLargeBlock: $AI_MANAGER_STORAGE_CLASS_LARGE_BLOCK
EOF

echo "Process completed .... "

}

