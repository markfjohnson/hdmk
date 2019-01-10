from __future__ import print_function
from kafka import KafkaConsumer
from cassandra.cluster import Cluster


import os, sys


cluster = Cluster(["node-0-server.cassandra.autoip.dcos.thisdcos.directory",
                   "node-1-server.cassandra.autoip.dcos.thisdcos.directory",
                   "node-2-server.cassandra.autoip.dcos.thisdcos.directory"])
session = cluster.connect()
KEYSPACE = "dcos"
rows = session.execute("SELECT keyspace_name FROM system_schema.keyspaces")
print("Found the Cassandra Keyspace: {}".format(rows[0]))

print("Getting ready to insert rows into the Cassandra table:TRANSACTIONS_DATA")
consumer = KafkaConsumer(
    'demo-transactions',
    bootstrap_servers=["broker.kafka.l4lb.thisdcos.directory:9092"],
    auto_offset_reset='earliest')

consumer.subscribe(["transactions"])

counter=0
for message in consumer:
    message = message.value
    data_elements = message.split(';')
    print('Message: {}'.format(message))

    session.execute(
        """
        INSERT INTO transaction_data (trans_date, field1,field2,field3)
        VALUES (%s, %s, %s, %s)
        """,
            (data_elements[0],data_elements[1],data_elements[2],data_elements[3]))
    counter = counter+1


print("Cassandra row inserts into USERS table is now complete.")
