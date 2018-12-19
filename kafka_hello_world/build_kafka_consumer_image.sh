#!/usr/bin/env bash
docker build -f Python-Kafka-Dockerfile -t markfjohnson/python-kafka-k8s .
docker push markfjohnson/python-kafka-k8s
