# Kubernetes communication with Kafka Cluster

## Requirements
* A working DC/OS cluster with the following services installed
    * Kafka (3 brokers, kafka service name="kafka")
    * Kubernetes and Kafka are available to the CLI
    * Kubernetes manager
    * Kubernetes cluster with the name 'kubernetes-cluster1'
* kubectl is setup and able to return the nodes available to Kubernetes
* The Docker image markfjohnson/python-kafka-k8s has been copied into your local repository if the cluster is airgapped.

If any of the above are not installed in the cluster, then consult with the Installation README of this repository.

## Run a Kubernetes Kafka producer pod
This Kubernetes service will generate data and store that data within the Kafka service

To begin you need to complete the following steps:

1. Confirm that ```kubectl``` command is properly configured
    ```kubectl get nodes```  
    If successful, you will see a list of nodes like that shown below:
    ```Marks-MacBook-Pro:hdmk markjohnson$ kubectl get nodes
     NAME                                                      STATUS    ROLES     AGE       VERSION
     kube-control-plane-0-instance.kubernetes-cluster1.mesos   Ready     master    47m       v1.12.3
     kube-node-0-kubelet.kubernetes-cluster1.mesos             Ready     <none>    44m       v1.12.3
     kube-node-1-kubelet.kubernetes-cluster1.mesos             Ready     <none>    44m       v1.12.3
     kube-node-2-kubelet.kubernetes-cluster1.mesos             Ready     <none>    44m       v1.12.3
     kube-node-3-kubelet.kubernetes-cluster1.mesos             Ready     <none>    44m       v1.12.3
     kube-node-4-kubelet.kubernetes-cluster1.mesos             Ready     <none>    44m       v1.12.3
     kube-node-5-kubelet.kubernetes-cluster1.mesos             Ready     <none>    44m       v1.12.3
     kube-node-public-0-kubelet.kubernetes-cluster1.mesos      Ready     <none>    43m       v1.12.3
     ```
1. Get the Kafka broker endpoints:
    ```dcos kafka endpoints broker```
    
    If the dcos Kafka CLI is properly setup for this example you should see the following endpoints list.  If the list differs, double check that the example requirements have been fulfilled.
    ```
      {
        "address": [
           "10.0.3.240:1025",
           "10.0.2.37:1025",
           "10.0.1.48:1025"
        ],
        "dns": [
           "kafka-0-broker.kafka.autoip.dcos.thisdcos.directory:1025",
           "kafka-1-broker.kafka.autoip.dcos.thisdcos.directory:1025",
           "kafka-2-broker.kafka.autoip.dcos.thisdcos.directory:1025"
        ],
        "vip": "broker.kafka.l4lb.thisdcos.directory:9092"
      }
      ```
      
1. If in an air gapped environment, be sure to copy the Docker image **mesosphere/flink-generator:0.1** into your private local repository.  Also, update the image name to reflect your private repository.
   **NOTE:** You may also have to modify the properties of the imagePullPolicy based on requirements established by your local repository.
   
1. Copy the Data Generator yaml shown below into a file called **kafka-demo-generator.yaml**
    ```angular2html
    apiVersion: apps/v1beta1
    kind: Deployment
    metadata:
      name: flink-demo-generator
    spec:
      replicas: 1
      template:
        metadata:
          name: flink-demo-generator
          labels:
            app: flink-demo-generator
        spec:
          containers:
           - name: flink-demo-generator
           image: mesosphere/flink-generator:0.1
           command: ["/generator-linux"]
           imagePullPolicy: Always
           args: ["--broker", "broker.kafka.l4lb.thisdcos.directory:9092"]
    ```
    As this is a YAML file, make certain the leading spaces are correctly copied.  The file can also get downloaded [here](https://raw.githubusercontent.com/dcos/demos/master/flink-k8s/1.11/generator/flink-demo-generator.yaml).  If you download the file, make certain to name the file kafka-demo-generator.yaml.
    
1. Deploy the generator as a Kafka service

    ```kubectl apply -f kafka-demo-generator.yaml```
    
1. Verify the demo generator has properly deployed
    ```
    kubectl get deployments
    kubectl get pods
    ```
    
    Once the demo generator has deployed you should see output for the above commands as shown below:
    ```
    Marks-MacBook-Pro:kafka_hello_world markjohnson$ kubectl get deployments
    NAME                   DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
    flink-demo-generator   1         1         1            1           53m
    
    Marks-MacBook-Pro:kafka_hello_world markjohnson$ kubectl get pods
    NAME                                    READY     STATUS    RESTARTS   AGE
    flink-demo-generator-6d8dc87d48-rvhtf   1/1       Running   0          54m
   ```
   
   Now that the generator is running it is time to confirm that messages are getting written into the "transactions" Kafka queue.
   
1. List the Kafka topics available and show the current message count in the "transactions" topic queue
    ```
    Marks-MacBook-Pro:kafka_hello_world markjohnson$ dcos kafka topic list
    [
      "transactions"
    ]
    Marks-MacBook-Pro:kafka_hello_world markjohnson$
    ```
    As we see in the above topic list the demo generator has correctly added the "transactions" Kafka topic.  The next step is to monitor the messages get posted into into the queue using the Kafka offsets command.  Run the following command a couple of times to see the offset count increasing which indicates an increase in the number of messages posted to the "transactions" topic.
    ```
    Marks-MacBook-Pro:kafka_hello_world markjohnson$ dcos kafka topic offsets transactions
    [
      {
        "0": "3324"
      }
    ]
    
    Marks-MacBook-Pro:kafka_hello_world markjohnson$ dcos kafka topic offsets transactions
    [
      {
        "0": "3330"
       }
    ]
    Marks-MacBook-Pro:kafka_hello_world markjohnson$
   ```

1. To view the data generated via the data generator tool by examining the pod logs execute the following command:
   ```
   Marks-MacBook-Pro:kafka_hello_world markjohnson$ kubectl logs flink-demo-generator-6d8dc87d48-rvhtf | more
   time="2018-12-19T02:42:22Z" level=info msg="&sarama.ProducerMessage{Topic:"transactions", Key:sarama.Encoder(nil), Value:"2018-12-19T02:42:21Z;2;6;8394", Metadata:interface {}(nil), Offset:0, Partition:0, Timestamp:time.Time{sec:0, nsec:0, loc:(*time.Location)(nil)}, retries:0, flags:0}"
   time="2018-12-19T02:42:23Z" level=info msg="&sarama.ProducerMessage{Topic:"transactions", Key:sarama.Encoder(nil), Value:"2018-12-19T02:42:23Z;4;0;3424", Metadata:interface {}(nil), Offset:1, Partition:0, Timestamp:time.Time{sec:0, nsec:0, loc:(*time.Location)(nil)}, retries:0, flags:0}"
   time="2018-12-19T02:42:24Z" level=info msg="&sarama.ProducerMessage{Topic:"transactions", Key:sarama.Encoder(nil), Value:"2018-12-19T02:42:24Z;2;3;7734", Metadata:interface {}(nil), Offset:2, Partition:0, Timestamp:time.Time{sec:0, nsec:0, loc:(*time.Location)(nil)}, retries:0, flags:0}"
   time="2018-12-19T02:42:25Z" level=info msg="&sarama.ProducerMessage{Topic:"transactions", Key:sarama.Encoder(nil), Value:"2018-12-19T02:42:25Z;4;6;2986", Metadata:interface {}(nil), Offset:3, Partition:0, Timestamp:time.Time{sec:0, nsec:0, loc:(*time.Location)(nil)}, retries:0, flags:0}"
   time="2018-12-19T02:42:26Z" level=info msg="&sarama.ProducerMessage{Topic:"transactions", Key:sarama.Encoder(nil), Value:"2018-12-19T02:42:26Z;9;7;8684", Metadata:interface {}(nil), Offset:4, Partition:0, Timestamp:time.Time{sec:0, nsec:0, loc:(*time.Location)(nil)}, retries:0, flags:0}"
   ```
   We have now completed the process of using a Kubernetes service calling a Kafka demo data generator and then posting those messages into a Kafka cluster managed by DC/OS and available to Kubernetes.
   
## Simple read from the "transactions" queue using a Kubernetes service
This example extends upon the last by establishing a K8s service to read the contents of the "transaction" topic which is getting populated by the kafka demo generator.

The requirements are the same as the prior example.

1. Create a file with the following text to serve as the **transaction-consumer.yaml** Kubernetes Deployment.  The the full text for the file is available [here](https://raw.githubusercontent.com/markfjohnson/hdmk/master/kafka_hello_world/transaction-consumer.yaml) if you wish to download rather than copy it from below.
    ```
    apiVersion: apps/v1beta1
    kind: Deployment
    metadata:
      name: transaction-consumer
    spec:
      replicas: 1
      template:
      metadata:
        name: transaction-consumer
        labels:
          app: transaction-consumer
      spec:
        containers:
        - name: demo-consumer
          image: markfjohnson/python-kafka-k8s
          command: ["/usr/local/bin/python"]
          imagePullPolicy: Always
          args: ["-u","/python-k8s-samples/kafka_consumer.py", "--broker", "broker.kafka.l4lb.thisdcos.directory:9092"]
    ```
    
1. Create the transaction-consumer deployment using the command:
   ```
   kubectl apply -f transaction-consumer.yaml
   ```
   
1. Validate the pod has been created and is running correctly
   ``` 
   Marks-MacBook-Pro:kafka_hello_world markjohnson$ kubectl get pods
   NAME                                    READY     STATUS    RESTARTS   AGE
   flink-demo-generator-6d8dc87d48-rvhtf   1/1       Running   0          3h
   transaction-consumer-9c599f68-zkcvs     1/1       Running   0          11m
   
   ```
   
1. Take the transaction-consumer-9c599f68-zkcvs  label from the get pods list and display the logs
   ``` 
   Marks-MacBook-Pro:kafka_hello_world markjohnson$ kubectl logs transaction-consumer-9c599f68-zkcvs | more

   Message: b'2018-12-19T02:42:21Z;2;6;8394'
   Message: b'2018-12-19T02:42:23Z;4;0;3424'
   Message: b'2018-12-19T02:42:24Z;2;3;7734'
   Message: b'2018-12-19T02:42:25Z;4;6;2986'
   Message: b'2018-12-19T02:42:26Z;9;7;8684'
   Message: b'2018-12-19T02:42:27Z;0;8;1901'
   Message: b'2018-12-19T02:42:28Z;8;0;619'
   Message: b'2018-12-19T02:42:29Z;8;1;8113'
   Message: b'2018-12-19T02:42:30Z;4;6;1927'
   Message: b'2018-12-19T02:42:31Z;0;3;7704'
   Message: b'2018-12-19T02:42:32Z;7;3;3466'
   Message: b'2018-12-19T02:42:34Z;1;6;471'
   Message: b'2018-12-19T02:42:37Z;9;2;6680'
   Message: b'2018-12-19T02:42:38Z;8;2;7388'
   Message: b'2018-12-19T02:42:39Z;6;2;3215'
   Message: b'2018-12-19T02:42:40Z;6;0;7840'
   Message: b'2018-12-19T02:42:41Z;4;7;3383'
   
   ```
   The output from the kubectl logs command will contain in a simplified format the data which was written originally by the data generator.
    