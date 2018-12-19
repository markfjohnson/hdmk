#!/usr/bin/env bash
dcos kafka endpoints broker
kubectl get nodes
kubectl apply -f kafka-demo-generator.yaml
sleep 5
kubectl get deployments
kubectl get pods
