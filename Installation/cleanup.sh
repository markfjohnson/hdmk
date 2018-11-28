#!/usr/bin/env bash
set -x
export AWS_DEFAULT_REGION="us-west-2"

terraform destroy
rm -rf ./.terraform/
rm -rf terraform.tfstate
rm -rf plan.out
rm -rf dcos-tf-aws-demo
rm -rf dcos-tf-aws-demo
