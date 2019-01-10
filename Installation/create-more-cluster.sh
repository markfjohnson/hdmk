#!/usr/bin/env bash
echo "==================================="
echo " Begin Installing the 1 K8s Clusters"
echo "==================================="
sh ./create_k8s_svc_accnt.sh kubernetes-cluster3
dcos kubernetes cluster create --yes --options=k8s_options1.json

echo "==================================="
echo " Begin Installing the 2 K8s Clusters"
echo "==================================="
sh ./create_k8s_svc_accnt.sh kubernetes-cluster4
dcos kubernetes cluster create --yes --options=k8s_options2.json

echo "==================================="
echo " Begin Installing the 1 K8s Clusters"
echo "==================================="
sh ./create_k8s_svc_accnt.sh kubernetes-cluster5
dcos kubernetes cluster create --yes --options=k8s_options1.json

echo "==================================="
echo " Begin Installing the 2 K8s Clusters"
echo "==================================="
sh ./create_k8s_svc_accnt.sh kubernetes-cluster6
dcos kubernetes cluster create --yes --options=k8s_options2.json
echo "==================================="
echo " Begin Installing the 1 K8s Clusters"
echo "==================================="
sh ./create_k8s_svc_accnt.sh kubernetes-cluster7
dcos kubernetes cluster create --yes --options=k8s_options1.json

echo "==================================="
echo " Begin Installing the 2 K8s Clusters"
echo "==================================="
sh ./create_k8s_svc_accnt.sh kubernetes-cluster8
dcos kubernetes cluster create --yes --options=k8s_options2.json
