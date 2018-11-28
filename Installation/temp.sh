#!/usr/bin/env bash
sh ./create_k8s_svc_accnt.sh kubernetes-cluster2
dcos kubernetes cluster create --options=k8s_options2.json
i=0

while [ $i -lt 10 ]
do
echo $i
i=$(dcos kubernetes cluster debug plan status deploy --cluster-name=kubernetes-cluster2 | grep -c COMPLETE)
done
echo "Kube 2 installed"