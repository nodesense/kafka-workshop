yes | cp -rf hadoop/hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml
yes | cp -rf hadoop/core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml
yes | cp -rf hadoop/mapred-site.xml $HADOOP_HOME/etc/hadoop/mapred-site.xml
yes | cp -rf hadoop/yarn-site.xml $HADOOP_HOME/etc/hadoop/yarn-site.xml

mkdirp /data/hdfs

chmod -R 777 /data/hdfs

hdfs namenode -format

