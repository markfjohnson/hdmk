from cassandra.cluster import Cluster
cluster = Cluster(["node-0-server.cassandra.autoip.dcos.thisdcos.directory",
                   "node-1-server.cassandra.autoip.dcos.thisdcos.directory",
                   "node-2-server.cassandra.autoip.dcos.thisdcos.directory"])
session = cluster.connect()
KEYSPACE = "dcos"
rows = session.execute("SELECT keyspace_name FROM system_schema.keyspaces")
if KEYSPACE in [row[0] for row in rows]:
    print("dropping existing keyspace...")
    session.execute("DROP KEYSPACE " + KEYSPACE)

print("creating keyspace...")
session.execute("""
        CREATE KEYSPACE %s
        WITH replication = { 'class': 'SimpleStrategy', 'replication_factor': '2' }
        """ % KEYSPACE)

print("setting keyspace...")
session.set_keyspace(KEYSPACE)
print("creating table transactions")
session.execute("""
        CREATE TABLE transactions_data (
            trans_date date,
            field1 int,
            field2 int,
            field3 int,
            PRIMARY KEY (date)
        )
        """)

