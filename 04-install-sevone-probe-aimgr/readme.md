# Installing SevOne Probe for Watson AIOps AI Manager

This document explains about Installing the Probe integration for IBM SevOne NPM connecting to IBM Watson AIOps AI Manager 3.6.0.

Installation scripts are available here [files](./files).

## 1. Update Properties

#### Update entitlement Keys

Update the below properties in `files/00-config.sh` file .

```
export ENTITLEMENT_KEY=eyJhbG...........................e4Zog
```

## 2. Install

#### 2.1. Login to OCP Cluster

Login to OCP cluster where AI-Manager is installed using  `oc login` command .

#### 2.2. Run the install script

Goto the `files` folder and Run the install script as like below.

```
cd files
sh 10-install.sh
```

- It would take around a minute to complete the istallation. 
- The same script can be run again and again if the install stopped for any reason.

#### 2.3. Output
 
The installation would be completed and the output could be like this.

```
PROBE_WEBHOOK_URL      : https://sevone-probe-mb-webhook-cp4waiops.aaaaaaaa/probe/sevone
PROBE_WEBHOOK_USER     : 
PROBE_WEBHOOK_PASSWORD : 
```

You can use this link in SevOne to push alerts.


Note: If have have any `ImagePullBackOff` related issue, you can run the same install script just few minutes later. it should solve the problem

```
webhookprobe.probes.integrations.noi.ibm.com/sevone-probe created
NAME                                              READY   STATUS                  RESTARTS   AGE
sevone-probe-mb-webhook-server-74d676b884-nlstd   0/1     Init:ImagePullBackOff   0          8s
```


## Reference

The script is based out of https://www.ibm.com/docs/en/cloud-paks/cloud-pak-watson-aiops/3.6.0?topic=integration-probe-sevone-npm-ai-manager