set -x

USER=`whoami`

#ssh-keygen -t rsa -P ""
#cat $HOME/.ssh/id_rsa.pub >> $HOME/.ssh/authorized_keys


apt update
#apt upgrade

apt install nodejs  -y

apt install openjdk-8-jdk curl wget jq -y

wget https://repo.anaconda.com/miniconda/Miniconda3-py37_4.10.3-Linux-x86_64.sh


# need to accept linux agreement
source https://repo.anaconda.com/miniconda/Miniconda3-py37_4.10.3-Linux-x86_64.sh


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
 
echo "KAFKA_HOME=/opt/confluent-5.5.5" >> /etc/environment
echo "CONFLUENT_HOME=/opt/confluent-5.5.5" >> /etc/environment

echo "SPARK_HOME=/$USER/spark-3.1.2-bin-hadoop2.7" >> /etc/environment


echo "export KAFKA_HOME=/opt/confluent-5.5.5" >> ~/.bashrc
echo "export PATH=\$PATH:\$KAFKA_HOME/bin" >>  ~/.bashrc


echo "export SPARK_HOME=/opt/spark-2.4.7-bin-hadoop2.7" >> ~/.bashrc
echo "export PATH=\$PATH:\$SPARK_HOME/bin" >>  ~/.bashrc
 

echo "export PATH=\$PATH:\$HADOOP_HOME/sbin:\$HADOOP_HOME/bin" >>  ~/.profile
echo "export PATH=\$PATH:\$SPARK_HOME/bin:\$SPARK_HOME/sbin" >>  ~/.profile

apt install mysql-server  -y
apt install apt-transport-https -y



wget http://packages.confluent.io/archive/5.5/confluent-5.5.5-2.12.tar.gz
tar xf confluent-5.5.5-2.12.tar.gz

sudo mv confluent-5.5.5 /opt

chmod 777 /opt/confluent-5.5.5


wget https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.47.tar.gz

tar xf mysql-connector-java-5.1.47.tar.gz
cp mysql-connector-java-5.1.47/*.jar /opt/confluent-5.5.5/share/java/kafka-connect-jdbc


wget https://archive.apache.org/dist/spark/spark-3.1.2/spark-3.1.2-bin-hadoop2.7.tgz

tar xf spark-3.1.2-bin-hadoop2.7.tgz

sudo mv spark-3.1.2-bin-hadoop2.7 /opt

chmod 777 /opt/spark-3.1.2-bin-hadoop2.7


# rm spark-2.3.2-bin-hadoop2.7.tgz


wget https://archive.apache.org/dist/hadoop/common/hadoop-2.7.7/hadoop-2.7.7.tar.gz

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
 
