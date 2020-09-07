set -x

USER=`whoami`

#ssh-keygen -t rsa -P ""
#cat $HOME/.ssh/id_rsa.pub >> $HOME/.ssh/authorized_keys


apt update
#apt upgrade

apt install nodejs  -y

apt install openjdk-8-jdk -y

apt install python -y

apt install jq -y

apt  install python-setuptools  -y
apt install python-pip  -y

echo "JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> /etc/environment
echo "JRE_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> /etc/environment 

echo "HADOOP_HOME=/$USER/hadoop-2.7.7" >>  /etc/environment

echo "HADOOP_INSTALL=/$USER/hadoop-2.7.7" >>  /etc/environment

echo "HADOOP_MAPRED_HOME=/$USER/hadoop-2.7.7" >>  /etc/environment

echo "HADOOP_COMMON_HOME=/$USER/hadoop-2.7.7" >>  /etc/environment

echo "HADOOP_HDFS_HOME=/$USER/hadoop-2.7.7" >>  /etc/environment
echo "YARN_HOME=/$USER/hadoop-2.7.7" >>  /etc/environment

echo "HADOOP_COMMON_LIB_NATIVE_DIR=/$USER/hadoop-2.7.7/lib/native" >>  /etc/environment
 
echo "KAFKA_HOME=/$USER/confluent-5.5.1" >> /etc/environment

echo "SPARK_HOME=/$USER/spark-2.3.2-bin-hadoop2.7" >> /etc/environment


echo "export PATH=\$PATH:\$HADOOP_HOME/sbin:\$HADOOP_HOME/bin" >>  ~/.profile
echo "export PATH=\$PATH:\$KAFKA_HOME/bin" >>  ~/.profile
echo "export PATH=\$PATH:\$SPARK_HOME/bin:\$SPARK_HOME/sbin" >>  ~/.profile

apt install mysql-server  -y
apt install apt-transport-https -y



wget http://packages.confluent.io/archive/5.5/confluent-5.5.1-2.12.tar.gz
tar xf confluent-5.5.1-2.12.tar.gz

wget https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.47.tar.gz

tar xf mysql-connector-java-5.1.47.tar.gz
cp mysql-connector-java-5.1.47/*.jar confluent-5.5.1/share/java/kafka-connect-jdbc


wget http://apache.cs.utah.edu/spark/spark-2.3.2/spark-2.3.2-bin-hadoop2.7.tgz

tar xf spark-2.3.2-bin-hadoop2.7.tgz

# rm spark-2.3.2-bin-hadoop2.7.tgz


wget https://www-eu.apache.org/dist/hadoop/common/hadoop-2.7.7/hadoop-2.7.7.tar.gz

tar xf hadoop-2.7.7.tar.gz

# rm hadoop-2.7.7.tar.gz


export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export JRE_HOME=/usr/lib/jvm/java-8-openjdk-amd64

export HADOOP_HOME=/$USER/hadoop-2.7.7


mv $HADOOP_HOME/etc/hadoop/core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml.original
mv $HADOOP_HOME/etc/hadoop/hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml.original
mv $HADOOP_HOME/etc/hadoop/mapred-site.xml $HADOOP_HOME/etc/hadoop/mapred-site.xml.original
mv $HADOOP_HOME/etc/hadoop/yarn-site.xml $HADOOP_HOME/etc/hadoop/yarn-site.xml.original


wget -P $HADOOP_HOME/etc/hadoop/ https://raw.githubusercontent.com/nodesense/kafka-workshop/master/hadoop/core-site.xml
wget -P $HADOOP_HOME/etc/hadoop/ https://raw.githubusercontent.com/nodesense/kafka-workshop/master/hadoop/hdfs-site.xml
wget -P $HADOOP_HOME/etc/hadoop/ https://raw.githubusercontent.com/nodesense/kafka-workshop/master/hadoop/mapred-site.xml
wget -P $HADOOP_HOME/etc/hadoop/ https://raw.githubusercontent.com/nodesense/kafka-workshop/master/hadoop/yarn-site.xml

ssh-keyscan localhost,0.0.0.0 > ~/.ssh/known_hosts
chmod +x hadoop-2.7.7/sbin/start-all.sh

mkdir -p /data/hdfs
#chown hduser:hadoop  /data/hadoop
chmod 777 /data/hdfs
 
