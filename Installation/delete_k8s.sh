#!/usr/bin/env bash
dcos kubernetes cluster delete --cluster-name=kubernetes-cluster1 --yes
dcos kubernetes cluster delete --cluster-name=kubernetes-cluster2 --yes
dcos package uninstall kubernetes --yes