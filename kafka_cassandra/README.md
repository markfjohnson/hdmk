# Kafka to Cassandra example in Kubernetes

This example is a continuation of the kafka_hello_world demo also contained within this repository.  All the requirements specified in the kafka_hello_world example plus those listed below are also the requirements for this example and will need to be followed for the example to work.
* cassandra package installed in the DC/OS cluster
* The Kafka 'transactions' topic created in the kafka_hello_world example exists and has messages within it.

## Run a Kubernetes service to create the necessary table to contain the "transactions data"
In this section we will execute a kubernetes job which will create a new Cassandra table to contain the transactions (and delete the table if it already exists).  If successful, then the job will output the created table DESCRIBE results to the pods logs.

1. Create a file containg the kubernetes deployment information to support creating the kubernetes job

1. Deploy the Kubernetes job
   ```
   kubectl apply -f cassandra-create-table.yaml
   ```

1. Validate that the Cassandra create tables job completed and the table exists
   ```
   kubectl get pods
   kubectl logs XXX

   ```
 
## Write the contents of the "transactions" topic into a cassandra table

Now that the Cassandra table has been created we will merge the ```kafka_consumer.py``` example from the kafka_hello_world example along with cassandra write logic to persit the data in the cassandra table.

1. Create a file containing the kubernetes deployment definition which will will read the Kafka "transactions" topic and write those results into the newly created Cassandra table.

1. Deploy the Kubernetes yaml file
    ```
    kubectl apply -f cassandra-write-transactions.yaml
    ```
    
1. Verify the write deployed successfully as a pod and the messages written to the cassandra table.
   ```
   kubectl get pods
   kubectl logs XXX
   ```
   
## Read the contents of the "transactions" topic from the cassandra table
