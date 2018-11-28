#!/usr/bin/env bash
dcos beta-kubernetes kubeconfig \
    --apiserver-url https://kube-apiserver.example.com:6443 \
    --path-to-custom-ca ca.pem \
    --no-activate-context