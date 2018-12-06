
USER=`whoami`

#ssh-keygen -t rsa -P ""
#cat $HOME/.ssh/id_rsa.pub >> $HOME/.ssh/authorized_keys


echo "deb http://www.apache.org/dist/cassandra/debian 311x main" | sudo tee -a /etc/apt/sources.list.d/cassandra.sources.list
curl https://www.apache.org/dist/cassandra/KEYS | sudo apt-key add -

wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -


apt update
#apt upgrade

apt install nodejs  -y


apt install openjdk-8-jdk -y

apt install python -y

apt install jq -y

apt  install python-setuptools  -y
apt install python-pip  -y
# pip install cassandra-driver



echo "JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> /etc/environment
echo "JRE_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> /etc/environment 

echo "HADOOP_HOME=/$USER/hadoop-2.7.7" >>  /etc/environment

echo "HADOOP_INSTALL=/$USER/hadoop-2.7.7" >>  /etc/environment

echo "HADOOP_MAPRED_HOME=/$USER/hadoop-2.7.7" >>  /etc/environment

echo "HADOOP_COMMON_HOME=/$USER/hadoop-2.7.7" >>  /etc/environment

echo "HADOOP_HDFS_HOME=/$USER/hadoop-2.7.7" >>  /etc/environment
echo "YARN_HOME=/$USER/hadoop-2.7.7" >>  /etc/environment

echo "HADOOP_COMMON_LIB_NATIVE_DIR=/$USER/hadoop-2.7.7/lib/native" >>  /etc/environment
 
echo "KAFKA_HOME=/$USER/confluent-5.0.1" >> /etc/environment

echo "SPARK_HOME=/$USER/spark-2.3.2-bin-hadoop2.7" >> /etc/environment


echo "export PATH=\$PATH:\$HADOOP_HOME/sbin:\$HADOOP_HOME/bin" >>  ~/.profile
echo "export PATH=\$PATH:\$KAFKA_HOME/bin" >>  ~/.profile
echo "export PATH=\$PATH:\$SPARK_HOME/bin:\$SPARK_HOME/sbin" >>  ~/.profile



apt install mysql-server  -y
apt install apt-transport-https -y

apt install elasticsearch -y


apt install cassandra  -y

#systemctl daemon-reload

systemctl enable cassandra
systemctl enable elasticsearch.service


systemctl start cassandra
systemctl start elasticsearch.service


#wget http://packages.confluent.io/archive/5.0/confluent-oss-5.0.1-2.11.tar.gz
#tar xf confluent-oss-5.0.1-2.11.tar.gz
#rm confluent-oss-5.0.1-2.11.tar.gz

# apt install libmysql-java

wget http://packages.confluent.io/archive/5.0/confluent-5.0.1-2.11.tar.gz
tar xf confluent-5.0.1-2.11.tar.gz

wget https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.47.tar.gz

tar xf mysql-connector-java-5.1.47.tar.gz
cp mysql-connector-java-5.1.47/*.jar confluent-5.0.1/share/java/kafka-connect-jdbc


wget http://apache.cs.utah.edu/spark/spark-2.3.2/spark-2.3.2-bin-hadoop2.7.tgz

tar xf spark-2.3.2-bin-hadoop2.7.tgz

# rm spark-2.3.2-bin-hadoop2.7.tgz


wget https://www-eu.apache.org/dist/hadoop/common/hadoop-2.7.7/hadoop-2.7.7.tar.gz

tar xf hadoop-2.7.7.tar.gz

# rm hadoop-2.7.7.tar.gz


export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export JRE_HOME=/usr/lib/jvm/java-8-openjdk-amd64

export HADOOP_HOME=/$USER/hadoop-2.7.7


mkdir -p /data/hdfs
#chown hduser:hadoop  /data/hadoop
chmod 777 /data/hdfs
 
