#!/usr/bin/env bash
set -x
dcos package install --yes dcos-enterprise-cli
dcos security org service-accounts keypair private-key.pem public-key.pem

dcos package install kubernetes --yes
sleep 60
echo "==================================="
echo " Begin Installing the 1 K8s Clusters"
echo "==================================="
sh ./create_k8s_svc_accnt.sh kubernetes-cluster1
dcos kubernetes cluster create --yes --options=k8s_options1.json

echo "==================================="
echo " Begin Installing the 2 K8s Clusters"
echo "==================================="
sh ./create_k8s_svc_accnt.sh kubernetes-cluster2
dcos kubernetes cluster create --yes --options=k8s_options2.json

echo "==================================="
echo " Waiting for K8s to finish installation"
echo "==================================="
i=0
while [ $i -gt 0 ]
do
i=$(dcos kubernetes cluster debug plan status deploy --cluster-name=kubernetes-cluster1 | grep -c "deploy (serial strategy) (COMPLETE)")
sleep 10
done
echo "K8s Cluster 1 installed"
dcos kubernetes cluster debug plan status deploy --cluster-name=kubernetes-cluster1
dcos kubernetes cluster debug plan status deploy --cluster-name=kubernetes-cluster2

echo "==================================="
echo " Install Edge"
echo "==================================="
## Setup Edge-LB
dcos package repo add --index=0 edgelb-pool https://downloads.mesosphere.com/edgelb-pool/v1.2.1/assets/stub-universe-edgelb-pool.json
dcos package repo add --index=0 edgelb https://downloads.mesosphere.com/edgelb/v1.2.1/assets/stub-universe-edgelb.json

dcos security org service-accounts keypair edge-lb-private-key.pem edge-lb-public-key.pem
dcos security org service-accounts create -p edge-lb-public-key.pem -d "Edge-LB service account" edge-lb-principal
dcos security org service-accounts show edge-lb-principal
dcos security secrets create-sa-secret --strict edge-lb-private-key.pem edge-lb-principal dcos-edgelb/edge-lb-secret
dcos security org groups add_user superusers edge-lb-principal


dcos package install --options=edge-lb-options.json edgelb --yes
j="ABC"
while [ $j -ne "pong" ]
do
j=$(dcos edgelb ping)
sleep 10
done
dcos edgelb create edgelb.json


echo "==================================="
echo " Edge Installation Complete"
echo "==================================="
dcos edgelb list
dcos edgelb status edgelb-kubernetes-cluster-proxy-basic
dcos task exec -it edgelb-pool-0-server curl ifconfig.co
