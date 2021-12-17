
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







```
cd modules.d
```

```
TODO: how to use modules.d
```


