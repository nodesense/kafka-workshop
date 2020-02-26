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
    
    Ctrl + W  - Write to file


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

    cat greetings.txt

