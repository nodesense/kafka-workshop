
$HADOOP_HOME/sbin/start-all.sh

$HADOOP_HOME/bin/hadoop fs -mkdir /tmp 
$HADOOP_HOME/bin/hadoop fs -mkdir /user

$HADOOP_HOME/bin/hadoop fs -mkdir /user/hive

$HADOOP_HOME/bin/hadoop fs -mkdir /user/hive/warehouse
$HADOOP_HOME/bin/hadoop fs -chmod g+w /tmp 
$HADOOP_HOME/bin/hadoop fs -chmod g+w /user/hive/warehouse
