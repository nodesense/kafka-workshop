Do this with mysql -uroot


GRANT  ALL ON *.* TO 'team'@'%' identified by 'team1234';

CREATE DATABASE workshop;
USE workshop;

create table products (id int, name varchar(255), price int, create_ts timestamp DEFAULT CURRENT_TIMESTAMP , update_ts timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP );

CREATE TABLE users (id varchar(42) primary key, fullname varchar(250), gender varchar(10), email varchar(100), phone varchar(20), state varchar(100), country varchar(50), membership varchar(20));


mysql --user=team --password=team1234 workshop

 insert into products (id, name, price) values(1,'Phone 1', 1000);

 insert into products (id, name, price) values(2,'Phone 2', 2000);
 update products set price=2200 where id=2;

 kafka-avro-console-consumer \
--bootstrap-server localhost:9092 \
--property schema.registry.url=http://localhost:8081 \
--property print.key=true \
--from-beginning \
--topic mysql-products

kafka-console-consumer \
--bootstrap-server localhost:9092 \
--from-beginning \
--property print.key=true \
--topic connect-offsets