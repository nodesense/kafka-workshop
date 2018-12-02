bash userpass.sh > secure.sql
mysql < db-setup.sql
mysql < secure.sql
