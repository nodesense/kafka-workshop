


echo "deb http://www.apache.org/dist/cassandra/debian 311x main" | sudo tee -a /etc/apt/sources.list.d/cassandra.sources.list
curl https://www.apache.org/dist/cassandra/KEYS | sudo apt-key add -

apt update
apt upgrade

apt install mariadb-server

apt install openjdk-8-jdk

apt install python -y

apt  install python-setuptools 
apt install python-pip
pip install cassandra-driver

apt install cassandra
systemctl enable cassandra
systemctl start cassandra


wget http://packages.confluent.io/archive/5.0/confluent-oss-5.0.1-2.11.tar.gz
tar xf confluent-oss-5.0.1-2.11.tar.gz
rm confluent-oss-5.0.1-2.11.tar.gz
