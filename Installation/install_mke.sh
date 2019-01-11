#!/usr/bin/env bash
#dcos package install --yes dcos-enterprise-cli
#dcos security org service-accounts keypair private-key.pem public-key.pem
#dcos security org service-accounts delete kubernetes
#dcos security org service-accounts create -p public-key.pem -d 'Kubernetes service account' kubernetes
#dcos security secrets delete kubernetes/sa
#dcos security secrets create-sa-secret private-key.pem kubernetes kubernetes/sa
#dcos security org users grant kubernetes dcos:superuser full
#dcos package install --yes kubernetes --options=MKE_options.json
#dcos kubernetes cluster create --options=k8s_mke_lab_options.json --yes
#
#
#dcos package install marathon-lb --yes

