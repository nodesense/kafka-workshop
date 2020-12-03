# Non-Secure Kafka Setup for Training/Development

# kafka-workshop
New repo with easy setup, for Ubuntu 18.04.

wget https://raw.githubusercontent.com/nodesense/kafka-workshop/master/system-setup.sh -O - -o /dev/null|bash






# Confluent

confluent start

# Hadoop

ssh-keygen -t rsa -P ""

cat $HOME/.ssh/id_rsa.pub >> $HOME/.ssh/authorized_keys

ssh localhost


mkdir -p /data/hdfs

chmod -R 777 /data/hdfs

hdfs namenode -format



start-all.sh

http://hostname:50070


# Consumer Group


    kafka-consumer-groups --bootstrap-server k5.nodesense.ai:9092 --list

    kafka-consumer-groups --bootstrap-server k5.nodesense.ai:9092 --describe --group invoice-consumer-example

with active members if any

    kafka-consumer-groups --bootstrap-server k5.nodesense.ai:9092 --describe --group invoice-consumer-example --members

 --state [assignment strategy, round robin, range]
 
    kafka-consumer-groups --bootstrap-server k5.nodesense.ai:9092 --describe --group invoice-consumer-example --state 


delete consumer group --group my-other-group1 --group my-other-group2

    kafka-consumer-groups --bootstrap-server localhost:9092 --delete --group  --group invoice-consumer-example
 

to reset offsets of a consumer group to the latest offset

    kafka-consumer-groups.sh --bootstrap-server localhost:9092 --reset-offsets --group consumergroup1 --topic topic1 --to-latest


Alter paritions

    kafka-topics --zookeeper k5.nodesense.ai:2181 --describe --topic greetings  
    
    kafka-topics --zookeeper k5.nodesense.ai:2181 --alter --topic greetings  --partitions 4
    
## HIVE
    default ports 10000

    rm -rf metastore_db/

    $HIVE_HOME/bin/schematool -initSchema -dbType derby

    bin/hive --service metastore
    
    
    jps 
    
    
    ps -ef | grep hiveserver2
    
     netstat -tulpn | grep :10000
     netstat -tnlpa | grep `cat /var/run/hive/hive-server.pid`
     
     $HIVE_HOME/bin/schematool -dbType derby -initSchema
     
     $HIVE_HOME/bin/hive --service hiveserver2
     
     $HIVE_HOME/bin/beeline -u jdbc:hive2://

     
 https://stackoverflow.com/questions/57232245/hiveserver2-hangs-while-starting-nothing-listening-on-port-10000
 

