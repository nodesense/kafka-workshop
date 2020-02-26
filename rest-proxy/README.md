
# REST PROXY

 PROXY between Http Client and Kafka Broker
 Runs on Port : 8082
 
 exposes end points for accessing kafka
 
 Allowing constrained/non-native kafka applications to consume/produce data with kafka
 
 
 List all topics
 
 Try with Putty/Shell
 
 
    http://k5.nodesense.ai:8082/topics
 
 
 Describe a topic
 
    http://k5.nodesense.ai:8082/topics/greetings
 
 
    kafka-console-consumer --bootstrap-server k5.nodesense.ai:9092 --topic greetings 
 

    curl -X POST -H "Content-Type: application/vnd.kafka.json.v2+json" \
           --data '{"records":[{"value":{"name": "testUser"}}]}' \
           "http://k5.nodesense.ai:8082/topics/greetings"
           
           
 
    curl -X POST -H "Content-Type: application/vnd.kafka.json.v2+json" \
           --data '{"records":[{"value":{"name": "testUser2"}}]}' \
           "http://k5.nodesense.ai:8082/topics/greetings"
           
           
 
     curl -X POST -H "Content-Type: application/vnd.kafka.json.v2+json" \
           --data '{"records":[{"value":{"name": "testUser3"}}]}' \
           "http://k5.nodesense.ai:8082/topics/greetings"
           
           
 With KEY Example
 
    kafka-console-consumer --bootstrap-server k5.nodesense.ai:9092 --topic greetings    --property print.key=true

 
    curl -X POST -H "Content-Type: application/vnd.kafka.json.v2+json" \
           --data '{"records":[{"key":"User10","value":{"name": "user10"}}]}' \
           "http://k5.nodesense.ai:8082/topics/greetings"
           
           
Susbcribe using REST PROXY
as HTTP is stateless, not always connected protocol, pull based
 
CREATE CONSUMER INSTANCE
 
    curl -X POST -H "Content-Type: application/vnd.kafka.v2+json" -H "Accept: application/vnd.kafka.v2+json" \
    --data '{"name": "greetings_kafka_http_client2", "format": "binary", "auto.offset.reset": "earliest"}' \
    http://k5.nodesense.ai:8082/consumers/greetings2_group
    
got response
    
    {"instance_id":"greetings_kafka_http_client1","base_uri":"http://k5.nodesense.ai:8082/consumers/greetings_group/instances/greetings_kafka_http_client1"}%
    
 Subscribe the consumer to a topic , need topic name
 
    curl -X POST -H "Content-Type: application/vnd.kafka.v2+json" --data '{"topics":["greetings"]}' \
     http://k5.nodesense.ai:8082/consumers/greetings2_group/instances/greetings_kafka_http_client2/subscription
    
    
 To consume the data
 
    curl -X GET -H "Accept: application/vnd.kafka.json.v2+json" \
     http://k5.nodesense.ai:8082/consumers/greetings2_group/instances/greetings_kafka_http_client2/records
     
 Delete subscription
 
    curl -X DELETE -H "Accept: application/vnd.kafka.v2+json" \
           http://localhost:8082/consumers/greetings_group/instances/greetings_kafka_http_client1



           