
set -x

USER=`whoami`

apt update

apt install openjdk-8-jdk -y

echo "JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> /etc/environment
echo "JRE_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> /etc/environment 

echo "HADOOP_HOME=/$USER/hadoop-2.7.7" >>  /etc/environment
echo "HADOOP_INSTALL=/$USER/hadoop-2.7.7" >>  /etc/environment
echo "HADOOP_MAPRED_HOME=/$USER/hadoop-2.7.7" >>  /etc/environment
echo "HADOOP_COMMON_HOME=/$USER/hadoop-2.7.7" >>  /etc/environment
echo "HADOOP_HDFS_HOME=/$USER/hadoop-2.7.7" >>  /etc/environment
echo "YARN_HOME=/$USER/hadoop-2.7.7" >>  /etc/environment
echo "HADOOP_COMMON_LIB_NATIVE_DIR=/$USER/hadoop-2.7.7/lib/native" >>  /etc/environment
 
echo "export PATH=\$PATH:\$HADOOP_HOME/sbin:\$HADOOP_HOME/bin" >>  ~/.profile

echo "HIVE_HOME=/$USER/apache-hive-2.3.7" >>  /etc/environment


wget https://archive.apache.org/dist/hadoop/common/hadoop-2.7.7/hadoop-2.7.7.tar.gz

tar xf hadoop-2.7.7.tar.gz

wget https://downloads.apache.org/hive/hive-2.3.7/apache-hive-2.3.7-bin.tar.gz
tar xf apache-hive-2.3.7-bin.tar.gz
mv apache-hive-2.3.7-bin apache-hive-2.3.7

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export JRE_HOME=/usr/lib/jvm/java-8-openjdk-amd64

export HADOOP_HOME=/$USER/hadoop-2.7.7

export HIVE_HOME=/$USER/apache-hive-2.3.7

mv $HADOOP_HOME/etc/hadoop/core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml.original
mv $HADOOP_HOME/etc/hadoop/hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml.original
mv $HADOOP_HOME/etc/hadoop/mapred-site.xml $HADOOP_HOME/etc/hadoop/mapred-site.xml.original
mv $HADOOP_HOME/etc/hadoop/yarn-site.xml $HADOOP_HOME/etc/hadoop/yarn-site.xml.original


export PATH=$PATH:$HIVE_HOME/bin
export CLASSPATH=$CLASSPATH:$HADOOP_HOME/lib/*:.
export CLASSPATH=$CLASSPATH:$HIVE_HOME/lib/*:.

cp $HIVE_HOME/conf/hive-env.sh.template $HIVE_HOME/conf/hive-env.sh
cp $HIVE_HOME/conf/hive-default.xml.template $HIVE_HOME/conf/hive-site.xml

wget http://archive.apache.org/dist/db/derby/db-derby-10.4.2.0/db-derby-10.4.2.0-bin.tar.gz
tar xf  db-derby-10.4.2.0-bin.tar.gz
mv db-derby-10.4.2.0-bin     db-derby-10.4.2.0

export DERBY_HOME=/$USER/db-derby-10.4.2.0
export PATH=$PATH:$DERBY_HOME/bin
export CLASSPATH=$CLASSPATH:$DERBY_HOME/lib/derby.jar:$DERBY_HOME/lib/derbytools.jar

mkdir -p  /data/derby

wget -P $HADOOP_HOME/etc/hadoop/ https://raw.githubusercontent.com/nodesense/kafka-workshop/master/hadoop/core-site.xml
wget -P $HADOOP_HOME/etc/hadoop/ https://raw.githubusercontent.com/nodesense/kafka-workshop/master/hadoop/hdfs-site.xml
wget -P $HADOOP_HOME/etc/hadoop/ https://raw.githubusercontent.com/nodesense/kafka-workshop/master/hadoop/mapred-site.xml
wget -P $HADOOP_HOME/etc/hadoop/ https://raw.githubusercontent.com/nodesense/kafka-workshop/master/hadoop/yarn-site.xml

ssh-keyscan localhost,0.0.0.0 > ~/.ssh/known_hosts
chmod +x hadoop-2.7.7/sbin/start-all.sh

mkdir -p /data/hdfs
#chown hduser:hadoop  /data/hadoop
chmod 777 /data/hdfs
