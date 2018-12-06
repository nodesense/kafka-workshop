wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -

sudo apt-get install apt-transport-https

sudo apt-get update && sudo apt-get install elasticsearch

sudo update-rc.d elasticsearch defaults 95 10

sudo -i service elasticsearch start

# sudo -i service elasticsearch stop

# Start elastic search when the system starts
sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable elasticsearch.service


# Start & Stop manually

# sudo systemctl start elasticsearch.service
# sudo systemctl stop elasticsearch.service