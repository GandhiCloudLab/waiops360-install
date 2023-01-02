#!/usr/bin/env bash

source ./00-config.sh

date1=$(date '+%Y-%m-%d %H:%M:%S')
echo "******************************************************************************************"
echo " IBM Cloud Pak for Watson AIOps AI-Manager delete started ....$date1"
echo "******************************************************************************************"


### Delete secrets
echo "-----------------------------------"
echo "Delete secrets"
echo "-----------------------------------"

oc delete secret ibm-entitlement-key -n $NAMESPACE 

### Delete SA, OperatorGroup, CatalogSource, Subscription and Installation
echo "-----------------------------------"
echo " Delete SA, OperatorGroup, CatalogSource, Subscription and Installation "
echo "-----------------------------------"

### Delete OperatorGroup 
oc delete OperatorGroup  cp4waiops-operator-group -n  $NAMESPACE

### Delete CatalogSource 
oc delete CatalogSource  ibm-operator-catalog -n openshift-marketplace

### Delete Subscription 
oc delete Subscription  ibm-aiops-orchestrator -n  $NAMESPACE

### Delete Installation 
oc delete Installation  ibm-aiops-orchestrator -n  $NAMESPACE

### Delete Installation 
oc delete Installation  ibm-aiops-orchestrator -n  $NAMESPACE


### Wait
echo "-----------------------------------"
echo "Waiting for 30 seconds"
echo "-----------------------------------"
sleep 30


### Delete Namespace 
echo "-----------------------------------"
echo "Create Namespace $NAMESPACE"
echo "-----------------------------------"
oc delete ns $NAMESPACE


echo "-----------------------------------"
echo "Most of the stuffs are deleted. You can manually go and delete if any operators available in the cp4waiops namespace"
echo "-----------------------------------"


date1=$(date '+%Y-%m-%d %H:%M:%S')
echo "******************************************************************************************"
echo " IBM Cloud Pak for Watson AIOps AI-Manager delete Completed ....$date1"
echo "******************************************************************************************"
