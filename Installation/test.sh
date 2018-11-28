#!/usr/bin/env bash
set -x
export DCOS_MASTER="$(terraform output cluster-address )"
export public_node="$(terraform output -input=false public-agents-loadbalancer)"
dcos cluster setup --username bootstrapuser --password deleteme --no-check ${DCOS_MASTER}
