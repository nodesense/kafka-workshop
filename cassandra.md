nodetool status



CREATE KEYSPACE cycling WITH replication = {'class':'SimpleStrategy', 'replication_factor' : 1};

 DESCRIBE keyspaces;
 
 USE cycling;
 
 
 CREATE TABLE cycling.cyclist_alt_stats ( id UUID PRIMARY KEY, lastname text, birthday timestamp, nationality text, weight text, height text );
