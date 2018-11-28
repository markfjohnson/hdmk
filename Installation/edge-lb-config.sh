#!/usr/bin/env bash
dcos package repo add --index=0 edgelb-pool https://downloads.mesosphere.com/edgelb-pool/v1.2.1/assets/stub-universe-edgelb-pool.json
dcos package repo add --index=0 edgelb https://downloads.mesosphere.com/edgelb/v1.2.1/assets/stub-universe-edgelb.json

dcos security org service-accounts keypair edge-lb-private-key.pem edge-lb-public-key.pem
dcos security org service-accounts create -p edge-lb-public-key.pem -d "Edge-LB service account" edge-lb-principal
dcos security org service-accounts show edge-lb-principal
dcos security secrets create-sa-secret --strict edge-lb-private-key.pem edge-lb-principal dcos-edgelb/edge-lb-secret
dcos security org groups add_user superusers edge-lb-principal


dcos package install --options=edge-lb-options.json edgelb --yes
dcos edgelb create edgelb.json
dcos edgelb list
dcos edgelb status edgelb-kubernetes-cluster-proxy-basic
dcos task exec -it edgelb-pool-0-server curl ifconfig.co