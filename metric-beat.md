metricbeat modules list

metricbeat modules enable kafka

metricbeat modules enable jolokia


systemctl restart metricbeat


----

export KAFKA_OPTS=-javaagent:/root/jolokia.jar=port=8778,host=localhost
kafka-console-producer --broker-list localhost:9092 --topic test


http://127.0.0.1:8778/jolokia/

---


in /etc/metricbeat/metricbeat.yml



```
metricbeat.modules:
# Module: jolokia
# Docs: https://www.elastic.co/guide/en/beats/metricbeat/7.x/metricbeat-module-jolokia.html

- module: jolokia
  metricsets: ["jmx"]
  period: 10s
  hosts: ["localhost:8775","localhost:8776","localhost:8777","localhost:8778"]
  namespace: "metrics"
  

  path: "/jolokia/?ignoreErrors=true&canonicalNaming=false"
  #username: "user"
  #password: "secret"
  jmx.mappings:
  - mbean: 'java.lang:type=Runtime'
    attributes:
      - attr: Uptime
        field: uptime
  - mbean: 'java.lang:type=Memory'
    attributes:
      - attr: HeapMemoryUsage
        field: memory.heap_usage
      - attr: NonHeapMemoryUsage
        field: memory.non_heap_usage
  # GC Metrics - this depends on what is available on your JVM
  - mbean: 'java.lang:type=GarbageCollector,name=ConcurrentMarkSweep'
    attributes:
      - attr: CollectionTime
        field: gc.cms_collection_time
      - attr: CollectionCount
        field: gc.cms_collection_count

  jmx.application:
  jmx.instance:
  
  

- module: kafka
  metricsets: ["producer"]
  period: 10s
  hosts: ["localhost:8778"]
  

- module: kafka
  metricsets: ["consumer"]
  period: 10s
  hosts: ["localhost:8778"]

  
```
