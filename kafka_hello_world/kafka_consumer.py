# Before running this program run pip install kafka-python
from kafka import KafkaConsumer
from json import loads
import sys, getopt

print('Number of arguments:', len(sys.argv), 'arguments.')
print('Argument List:', str(sys.argv))
broker = ''

try:
    opts, args = getopt.getopt(sys.argv, "hi:", ["broker="])
except getopt.GetoptError:
    print('test.py -i <inputfile> -o <outputfile>')
    sys.exit(2)

for opt, arg in opts:
    if opt == '-h':
        print('test.py -i <inputfile> -o <outputfile>')
        sys.exit()
    elif opt in ("-b", "--broker"):
        broker = arg

consumer = KafkaConsumer(
    'demo-transactions',
    bootstrap_servers=[broker],
    auto_offset_reset='earliest',
    enable_auto_commit=True,
    group_id='my-group',
    value_deserializer=lambda x: loads(x.decode('utf-8')))

for message in consumer:
    message = message.value
    print('Message: {}'.format(message))
