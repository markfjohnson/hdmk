#!/usr/bin/env bash
dcos kafka endpoints broker
dcos kubernetes cluster debug plan status deploy --cluster-name=kubernetes-cluster1
kubectl get nodes
kubectl apply -f kafka-demo-generator.yaml
sleep 10
kubectl get deployments
kubectl get pods
sleep 30
dcos kafka topic list
dcos kafka topic offsets transactions
