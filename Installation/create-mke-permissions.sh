#!/usr/bin/env bash
dcos security org service-accounts keypair mke-priv.pem mke-pub.pem
dcos security org service-accounts create -p mke-pub.pem -d 'Kubernetes Engine service account' $1
dcos security secrets create-sa-secret mke-priv.pem $1 $1/sa
dcos security org users grant $1 dcos:mesos:master:reservation:role:$1-role create
dcos security org users grant $1 dcos:mesos:master:framework:role:$1-role create
dcos security org users grant $1 dcos:mesos:master:task:user:nobody create


