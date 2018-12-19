#!/usr/bin/env bash
set -x
eval $(maws li 110465657741_Mesosphere-PowerUser)
export AWS_DEFAULT_REGION="us-west-2"

terraform destroy
rm -rf ./.terraform/
rm -rf terraform.tfstate
rm -rf plan.out
rm -rf dcos-tf-aws-demo
rm -rf dcos-tf-aws-demo
