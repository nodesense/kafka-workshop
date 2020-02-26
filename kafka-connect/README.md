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

