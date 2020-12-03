
set -x

USER=`whoami`
HOSTNAME=`hostname -f`

apt update

apt install openjdk-8-jdk -y

wget https://archive.apache.org/dist/hadoop/common/hadoop-2.7.7/hadoop-2.7.7.tar.gz
wget https://downloads.apache.org/hive/hive-2.3.7/apache-hive-2.3.7-bin.tar.gz
wget http://archive.apache.org/dist/db/derby/db-derby-10.4.2.0/db-derby-10.4.2.0-bin.tar.gz

tar xf hadoop-2.7.7.tar.gz
tar xf apache-hive-2.3.7-bin.tar.gz
mv apache-hive-2.3.7-bin apache-hive-2.3.7
tar xf  db-derby-10.4.2.0-bin.tar.gz
mv db-derby-10.4.2.0-bin     db-derby-10.4.2.0


export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export JRE_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export HADOOP_HOME=/$USER/hadoop-2.7.7
export HIVE_HOME=/$USER/apache-hive-2.3.7
export DERBY_HOME=/$USER/db-derby-10.4.2.0
export HIVE_PORT=10000


export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin
export PATH=$PATH:$DERBY_HOME/bin
export PATH=$PATH:$HIVE_HOME/bin

export CLASSPATH=$CLASSPATH:$DERBY_HOME/lib/derby.jar:$DERBY_HOME/lib/derbytools.jar
export CLASSPATH=$CLASSPATH:$HADOOP_HOME/lib/*:.
export CLASSPATH=$CLASSPATH:$HIVE_HOME/lib/*:.

echo "JAVA_HOME=$JAVA_HOME" >> /etc/environment
echo "JRE_HOME=$JRE_HOME" >> /etc/environment 

echo "HADOOP_HOME=/$USER/hadoop-2.7.7" >>  /etc/environment
echo "HADOOP_INSTALL=/$USER/hadoop-2.7.7" >>  /etc/environment
echo "HADOOP_MAPRED_HOME=/$USER/hadoop-2.7.7" >>  /etc/environment
echo "HADOOP_COMMON_HOME=/$USER/hadoop-2.7.7" >>  /etc/environment
echo "HADOOP_HDFS_HOME=/$USER/hadoop-2.7.7" >>  /etc/environment
echo "YARN_HOME=/$USER/hadoop-2.7.7" >>  /etc/environment
echo "HADOOP_COMMON_LIB_NATIVE_DIR=/$USER/hadoop-2.7.7/lib/native" >>  /etc/environment
echo "HIVE_HOME=/$USER/apache-hive-2.3.7" >>  /etc/environment
echo "DERBY_HOME=/$USER/db-derby-10.4.2.0" >>  /etc/environment
echo "HIVE_PORT=10000" >>  /etc/environment
 
echo "export PATH=\$PATH:\$HADOOP_HOME/sbin:\$HADOOP_HOME/bin" >>  ~/.profile

export HIVE_PORT=10000

mv $HADOOP_HOME/etc/hadoop/core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml.original
mv $HADOOP_HOME/etc/hadoop/hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml.original
mv $HADOOP_HOME/etc/hadoop/mapred-site.xml $HADOOP_HOME/etc/hadoop/mapred-site.xml.original
mv $HADOOP_HOME/etc/hadoop/yarn-site.xml $HADOOP_HOME/etc/hadoop/yarn-site.xml.original

cp $HIVE_HOME/conf/hive-env.sh.template $HIVE_HOME/conf/hive-env.sh
# cp $HIVE_HOME/conf/hive-default.xml.template $HIVE_HOME/conf/hive-site.xml

wget -P $HIVE_HOME/conf https://raw.githubusercontent.com/nodesense/kafka-workshop/master/hadoop/hive-site.xml




wget -P $HADOOP_HOME/etc/hadoop/ https://raw.githubusercontent.com/nodesense/kafka-workshop/master/hadoop/core-site.xml
wget -P $HADOOP_HOME/etc/hadoop/ https://raw.githubusercontent.com/nodesense/kafka-workshop/master/hadoop/hdfs-site.xml
wget -P $HADOOP_HOME/etc/hadoop/ https://raw.githubusercontent.com/nodesense/kafka-workshop/master/hadoop/mapred-site.xml
wget -P $HADOOP_HOME/etc/hadoop/ https://raw.githubusercontent.com/nodesense/kafka-workshop/master/hadoop/yarn-site.xml

ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa <<<y 2>&1 >/dev/null
cat $HOME/.ssh/id_rsa.pub >> $HOME/.ssh/authorized_keys


ssh-keyscan localhost,0.0.0.0,k1.training.sh > ~/.ssh/known_hosts
chmod +x hadoop-2.7.7/sbin/start-all.sh

rmdir -rf /data

mkdir -p /data/hdfs
chmod 777 /data/hdfs
mkdir -p  /data/derby
chmod 777 /data/derby

hdfs namenode -format

$HADOOP_HOME/sbin/start-all.sh

$HADOOP_HOME/bin/hadoop fs -mkdir /tmp 
$HADOOP_HOME/bin/hadoop fs -mkdir /user

$HADOOP_HOME/bin/hadoop fs -mkdir /user/hive

$HADOOP_HOME/bin/hadoop fs -mkdir /user/hive/warehouse
$HADOOP_HOME/bin/hadoop fs -chmod g+w /tmp 
$HADOOP_HOME/bin/hadoop fs -chmod g+w /user/hive/warehouse
