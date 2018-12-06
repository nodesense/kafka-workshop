CREATE DATABASE workshop;
USE workshop;

CREATE TABLE users (id varchar(42) primary key, fullname varchar(250), gender varchar(10), email varchar(100), phone varchar(20), state varchar(100), country varchar(50), membership varchar(20));
CREATE TABLE products (id varchar(42) primary key, name varchar(255), category varchar(255), price int, create_ts timestamp DEFAULT CURRENT_TIMESTAMP , update_ts timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP );

