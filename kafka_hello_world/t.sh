kubectl delete deployments transaction-consumer
sh ./build_kafka_consumer_image.sh
kubectl apply -f transaction-consumer.yaml
kubectl get pods
