confluent load jdbc_source_mysql_foobar_01 -d  kafka-connect-jdbc-source.json

confluent status jdbc_source_mysql_foobar_01

kafka-avro-console-consumer \
--bootstrap-server localhost:9092 \
--property schema.registry.url=http://localhost:8081 \
--property print.key=true \
--from-beginning \
--topic mysql-foobar

------

confluent load file-sink-mysql-foobar -d kafka-connect-file-sink.json
confluent status file-sink-mysql-foobar

tail -f /tmp/kafka-mysql-foobar.txt



confluent load es-sink-mysql-foobar-01 -d kafka-connect-elasticsearch-sink.json

curl -s "http://localhost:9200/mysql-foobar/_search"|jq '.hits'





---
Write to MySQL Table

Refer mysql-kafka-sink.properties

kafka-avro-console-producer \
 --broker-list localhost:9092 --topic orders \
 --property value.schema='{"type":"record","name":"myrecord","fields":[{"name":"id","type":"int"},{"name":"product", "type": "string"}, {"name":"quantity", "type": "int"}, {"name":"price",
 "type": "float"}]}'


{"id": 999, "product": "foo", "quantity": 100, "price": 50}

$ sqlite3 test.db
sqlite> select * from orders;
