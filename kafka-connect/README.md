# Kafka Connect

To start Confluent setup

`confluent start`

Confluent service status

`confluent status`

List all connectors

`confluent list connectors`

List status of the running connectors

`confluent status connectors`


display status of the specific connector

`confluent status <<connector-id>>`


## Working with Connectors

1. [File Source Connector](./docs/file-source-connector.md)


# Using File Source Connectors

### NANO EDITOR

    To open a file,

    nano filepath

    Ctrl + X - To Quit, it will to save or leave without saving file
    
    Ctrl + O  - Write to file


Create a property file for connector configureation/Source connector

    touch file-source.properties

    nano file-source.properties

and below content 
```
name=stock-file-source
connector.class=FileStreamSource
tasks.max=1
file=/root/stocks.csv
topic=stocks
```

#DONE


    touch stocks.csv

Load the connectors into kafka?, this will load source connector, keep watching for  stocks.csv changes

    confluent load stock-file-source -d file-source.properties

Check whether connector is running or not

    confluent status connectors

To know specific connector status

    confluent status stock-file-source

Put some data into csv file

    echo "1234,10" >> stocks.csv

    echo "1235,20" >> stocks.csv

    echo "1236,30" >> stocks.csv


    cat stocks.csv



# Second command prompt in your Windows/Linux Putty shell

    kafka-console-consumer --bootstrap-server k5.nodesense.ai:9092 --topic stocks --from-beginning

# FILE SINK Connectors


Consume data from Kafka Topics and write to file

    touch output-file.csv

    touch file-sink.properties

    nano file-sink.properties

paste below content

```
name=stock-file-sink
connector.class=FileStreamSink
tasks.max=1
file=/root/output-file.csv
topics=stocks
```

Load connector

    confluent load stock-file-sink -d file-sink.properties

Check status

    confluent status connectors

    confluent status stock-file-sink

    cat output-file.csv


Add a line to stocks

    echo "1237,30" >> stocks.csv

Check if reflected in output-file.csv

    cat output-file.csv


### Using Converters

    touch greetings.txt

    touch greetings-file-sink.properties

    nano greetings-file-sink.properties

paste below content

```
name=greetings-file-sink
connector.class=FileStreamSink
tasks.max=1
file=/root/greetings.txt
topics=greetings
key.converter=org.apache.kafka.connect.storage.StringConverter
value.converter=org.apache.kafka.connect.storage.StringConverter
```


Load connector

    confluent load greetings-file-sink -d greetings-file-sink.properties

Check status

    confluent status connectors

    confluent status greetings-file-sink

Run SimpleProducer.java, produce to topic greetings

    cat greetings.txt


## One last example Avro and file sink

    touch invoices.txt


    touch invoices-file-sink.properties

    nano invoices-file-sink.properties

paste below content

```
name=invoices-file-sink
connector.class=FileStreamSink
tasks.max=1
file=/root/invoices.txt
topics=invoices
key.converter=io.confluent.connect.avro.AvroConverter
value.converter=io.confluent.connect.avro.AvroConverter
key.converter.schema.registry.url=http://k5.nodesense.ai:8081
value.converter.schema.registry.url=http://k5.nodesense.ai:8081
```

Load connectors

    confluent load invoices-file-sink -d invoices-file-sink.properties
    
    confluent status invoices-file-sink
 

Then Run InvoiceProducer.java

    cat invoices.txt


## JSON Converter type, NOT WORKING



    touch invoices.json


    touch invoices-json-sink.properties

    nano invoices-json-sink.properties

paste below content

```
name=invoices-json-sink
connector.class=FileStreamSink
tasks.max=1
file=/root/invoices.json
topics=invoices
key.converter=io.confluent.connect.avro.AvroConverter
value.converter=org.apache.kafka.connect.json.JsonConverter
key.converter.schema.registry.url=http://k5.nodesense.ai:8081
value.converter.schema.registry.url=http://k5.nodesense.ai:8081
```

Load connectors

    confluent load invoices-json-sink -d invoices-json-sink.properties
    
    confluent status invoices-json-sink
 

Then Run InvoiceProducer.java

    cat invoices.json



MYSQL

MySQL JDBC not included in Kafka Distribution

Devleopers to download jdbc jars of oracle/mysql/ms sql


    wget https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.47.tar.gz

    tar xf mysql-connector-java-5.1.47.tar.gz
    
    cp mysql-connector-java-5.1.47/*.jar confluent-5.2.2/share/java/kafka-connect-jdbc


                       
Implmenting MYSQL Source connector
 Whenever new record inserted/updated, publish to kafka
 JDBC Datasources, can use Avro, Schema registry
 It automatically build avro schema from database table
 
 
## Setup the database 

    mysql -uroot


    CREATE USER 'team'@'localhost' IDENTIFIED BY 'team1234';

    CREATE DATABASE ecommerce; 

    GRANT ALL PRIVILEGES ON ecommerce.* TO 'team'@'localhost';


Exit from the shell

    mysql -uroot

    USE ecommerce;

detect insert/update changes using timestamp , not delete

```
create table products (id int, 
                       name varchar(255), 
                       price int, 
                       create_ts timestamp DEFAULT CURRENT_TIMESTAMP, 
                       update_ts timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP );
```     
             
             
Settings can be done in json or properties file

### START PROPERTY JSON CONFIGURATION
 
    touch mysql-product-source.json
 
    nano  mysql-product-source.json
   
paste below
```   
{
"name": "mysql-product-source",
"config": {
    "connector.class": "io.confluent.connect.jdbc.JdbcSourceConnector",
    "key.converter": "io.confluent.connect.avro.AvroConverter",
    "key.converter.schema.registry.url": "http://k5.nodesense.ai:8081",
    "value.converter": "io.confluent.connect.avro.AvroConverter",
    "value.converter.schema.registry.url": "http://k5.nodesense.ai:8081",
    "connection.url": "jdbc:mysql://localhost:3306/ecommerce?user=team&password=team1234",
    "_comment": "Which table(s) to include",
    "table.whitelist": "products",
    "mode": "timestamp",
    "timestamp.column.name": "update_ts",
    "validate.non.null": "false",
    "_comment": "The Kafka topic will be made up of this prefix, plus the table name  ",
    "topic.prefix": "db_"
}
}
```
 

Note: the topic shall be <<PREFIX>>+<<TableName>> example: db_products
 
 
    confluent load mysql-product-source -d mysql-product-source.json
 
    confluent status connectors
 
    confluent status mysql-product-source
 

### Run below on your system or different putty/ssh

    kafka-avro-console-consumer --bootstrap-server k5.nodesense.ai:9092 --topic db_products --from-beginning --property schema.registry.url="http://k5.nodesense.ai:8081"

### Use Different Putty 

    mysql -uroot
 
    USE ecommerce;


    insert into products (id, name, price) values(1,'google phone', 2000); 
 
 
    insert into products (id, name, price) values(2,'nexus phone', 3000); 
 
    update products set price=3333 where id=1; 


### CHECK IN Browser for Schema registration


check http://k5.nodesense.ai:8081/subjects  
to ensure that you have schema for products listed
 
 http://k5.nodesense.ai:8081/subjects/db_products-value/versions/1
 
    
## MYSQL SINK Connectors
  Consume from Topics, write to database
  kafka-avro-console-producers
  
    touch  mysql-product-sink.properties

    nano  mysql-product-sink.properties

```
name=mysql-product-sink
connector.class=io.confluent.connect.jdbc.JdbcSinkConnector
tasks.max=1
topics=products
connection.url=jdbc:mysql://localhost:3306/ecommerce?user=team&password=team1234
auto.create=true
key.converter=io.confluent.connect.avro.AvroConverter
key.converter.schema.registry.url=http://k5.nodesense.ai:8081
value.converter=io.confluent.connect.avro.AvroConverter
value.converter.schema.registry.url=http://k5.nodesense.ai:8081
```

consume from products topics, write to products table

To write  to specific table name,

use belwo property

table.name.format=mst_${topic}

table.name.format=somename_table


    confluent load mysql-product-sink -d  mysql-product-sink.properties
    
   
    confluent status connectors
    
    confluent status  mysql-product-sink
    
    
    

Check with below command.

    kafka-avro-console-producer --broker-list k5.nodesense.ai:9092 --topic products --property value.schema='{"type":"record","name":"product","fields":[{"name":"id","type":"int"},{"name":"name", "type": "string"}, {"name":"price", "type": "int"}]}'  --property schema.registry.url="http://k5.nodesense.ai:8081"
   

paste below line one after another without new line

{"id": 999, "name": "asus pro", "price": 100}


-- in db,

    select * from products;

check whether id 999 appears ot not
