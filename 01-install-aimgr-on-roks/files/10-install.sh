#!/usr/bin/env bash

source ./00-config.sh

source ./common/01-create-namespace-secret-catalog-source.sh
source ./common/02-create-subscription.sh
source ./common/03-verify-operator-pod.sh
source ./common/04-create-crd-installation.sh
source ./common/05-verify-crd-installation.sh
source ./common/06-verify-pods-count.sh
source ./common/07-configure-signed-certifications-for-nginx.sh
source ./common/21-print-aiops-console-url-pwd.sh


install_main() {

  date1=$(date '+%Y-%m-%d %H:%M:%S')
  echo "******************************************************************************************"
  echo " IBM Cloud Pak for Watson AIOps AI-Manager started ....$date1"
  echo "******************************************************************************************"
  
  create_namespace_secret_catalog_source
  create_subscription
  verify_operator_pod
  if [[ $GLOBAL_POD_VERIFY_STATUS == "true" ]]; then 
    create_crd_installation
    verify_crd_installation
    if [[ $GLOBAL_VERIFY_STATUS == "true" ]]; then 
      verify_pods_count
      if [[ $GLOBAL_POD_VERIFY_STATUS == "true" ]]; then 
        configure_signed_certificates_for_NGINX
        print_aiops_console_url_pwd
      fi  
    fi
  fi

  date1=$(date '+%Y-%m-%d %H:%M:%S')
  echo "******************************************************************************************"
  echo " IBM Cloud Pak for Watson AIOps AI-Manager completed ....$date1"
  echo "******************************************************************************************"

}

install_main