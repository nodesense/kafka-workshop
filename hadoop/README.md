


# HADOOP

Open separate putty


    ssh-keygen -t rsa -P ""

press enter key to save the public key

    cat $HOME/.ssh/id_rsa.pub >> $HOME/.ssh/authorized_keys

    ssh localhost

    mkdir -p /data/hdfs

    chmod -R 777 /data/hdfs

    hdfs namenode -format

    start-all.sh

Chech browser with
    
    http://hostname:50070


    http://k5.training.sh:50070/explorer.html#/


# HDFS Sink Connector


    touch hdfs-sink.properties

    nano hdfs-sink.properties



hdfs-sink.properties

```
name=hdfs-sink
connector.class=io.confluent.connect.hdfs.HdfsSinkConnector
tasks.max=1
topics=greetings
hdfs.url=hdfs://localhost:9000
flush.size=3
key.converter=org.apache.kafka.connect.storage.StringConverter
value.converter=org.apache.kafka.connect.storage.StringConverter
```


    confluent load hdfs-sink -d hdfs-sink.properties

    confluent status connectors

    confluent status hdfs-sink

Now check browser with http://k1.training.sh:50070/explorer.html#/

Check if the topic present in 

http://k1.training.sh:50070/explorer.html#/topics
