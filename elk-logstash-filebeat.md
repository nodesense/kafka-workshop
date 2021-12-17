
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













```
cd modules.d
```

```
TODO: how to use modules.d
```


