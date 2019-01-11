#!/usr/bin/env bash
set -x

echo "starting now"
edge_cnt=0
while [ $edge_cnt == 0 ]
do
    sleep 5
    edge_res = "dcos edgelb list | grep -c 'edgelb-kubernetes-cluster-proxy-basic'"
    eval $edge_res
    echo $edge_cnt
done
