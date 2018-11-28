#!/usr/bin/env bash
set -x
dcos package install --yes dcos-enterprise-cli
dcos security org service-accounts keypair private-key.pem public-key.pem

dcos package install kubernetes --yes
sleep 60
sh ./create_k8s_svc_accnt.sh kubernetes-cluster1
dcos kubernetes cluster create --yes --options=k8s_options1.json


sh ./create_k8s_svc_accnt.sh kubernetes-cluster2
dcos kubernetes cluster create --yes --options=k8s_options2.json
dcos package install marathon-lb --yes
sleep 30
while [ $i -lt 1 ]
do
i=$(dcos kubernetes cluster debug plan status deploy --cluster-name=kubernetes-cluster1 | grep -c "deploy (serial strategy) (COMPLETE)")
echo $i
done
echo "K8s Cluster 1 installed"
dcos kubernetes cluster debug plan status deploy --cluster-name=kubernetes-cluster1
dcos kubernetes cluster debug plan status deploy --cluster-name=kubernetes-cluster2
#dcos marathon app add MLB-k8s-proxy1.json

