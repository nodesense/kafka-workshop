
```
apt install openjdk-8-jdk -y
```

## FileBeat

https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-installation-configuration.html

```
curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.16.1-linux-x86_64.tar.gz

tar xzvf filebeat-7.16.1-linux-x86_64.tar.gz
```

``
cd filebeat-7.16.1-linux-x86_64/
```

```
./filebeat modules list
```

```
./filebeat modules enable system 
```


```
nano filebeat.yml
```




Add below output to kafka 

```
output.kafka:
  hosts: ["localhost:9092"]
  topic: "log-topic"
  codec.json:
    pretty: false
```

disable `output.elasticsearch` settings

enable `host: "localhost:5601"` in setup.kibana settings.


## start filebeat

```
./filebeat -e
```




## Log stash

```
wget https://artifacts.elastic.co/downloads/logstash/logstash-7.16.1-linux-x86_64.tar.gz
tar xf logstash-7.16.1-linux-x86_64.tar.gz
```

To run logstash,

```
cd logstash-7.16.1
bin/logstash -f logstash.conf
```

setup filters, input/output, pipeline, pipeline works, batchsize , batch delay.. enable api, api host/port in logstash..


```
 nano logstash.yml
 ```

```
...
 node.name: test

...
 path.data: /root/logstash/data

...
 pipeline.id: main

...

 pipeline.workers: 2
 
 ...
 
  pipeline.batch.size: 125

```

## to run multiple pipelines

```
nano pipelines.yml
```

------------------------------

## Elastic search

```
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.16.1-linux-x86_64.tar.gz
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.16.1-linux-x86_64.tar.gz.sha512
shasum -a 512 -c elasticsearch-7.16.1-linux-x86_64.tar.gz.sha512 
tar -xzf elasticsearch-7.16.1-linux-x86_64.tar.gz
cd elasticsearch-7.16.1/ 
```


default port : 9200
```
nano elasticsearch.yml
```



```
network.host: 65.21.xyz.abc
....

discovery.seed_hosts: ["127.0.0.1", "[::1]"]
```

# To start serviecs

filebeat

logstash

#### elastic search:

to run on terminal, we cannot run elastic search as root

https://stackoverflow.com/questions/40766301/run-elastic-search-as-root-user

```
sudo useradd elasticsearch
sudo addgroup elasticsearch
sudo adduser --ingroup elasticsearch elasticsearch


sudo chown elasticsearch:elasticsearch -R  /root/elasticsearch-7.16.1

passwd elasticsearch

use elasticsearch as password

```
sudo mkhomedir_helper elasticsearch


ls -al /home/elasticsearch


sudo useradd -m -d /home/elasticsearch elasticsearch


```

su elasticsearch

# passwd elasticsearch



sudo less /etc/passwd | grep "elasticsearch"
sudo less /etc/group | grep "elasticsearch"
```

su 


./bin/elasticsearch -Des.insecure.allow.root=true

/root/elasticsearch-7.16.1

```
./bin/elasticsearch
```

to run as daemon

```
./bin/elasticsearch -d
```

For kibana using linux apt

https://www.rosehosting.com/blog/how-to-install-elk-stack-on-ubuntu-20-04/

http://ip:5601/app/home




https://linuxize.com/post/how-to-install-elasticsearch-on-ubuntu-18-04/






confluent kafka

 

