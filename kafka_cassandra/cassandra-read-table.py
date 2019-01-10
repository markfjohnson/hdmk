from cassandra.cluster import Cluster

cluster = Cluster(["node-0-server.cassandra.autoip.dcos.thisdcos.directory",
                   "node-1-server.cassandra.autoip.dcos.thisdcos.directory",
                   "node-2-server.cassandra.autoip.dcos.thisdcos.directory"])
session = cluster.connect()
KEYSPACE = "dcos"
rows = session.execute("SELECT keyspace_name FROM system_schema.keyspaces")
print("Found the Cassandra Keyspace: {}".format(rows[0]))

rows = session.execute('SELECT * FROM users')
print("TRANS_DATE","FIELD1","FIELD2","FIELD3")
for (trans_date, field1, field2, field3) in rows:
    print(trans_date, field1, field2, field3)