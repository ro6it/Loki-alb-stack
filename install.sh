#!/bin/bash

echo " #################################################### Installing JDK ################################################"
echo ''
echo ''
echo ''
apt install openjdk-11-jre -y
echo ''
echo ''
echo ''
echo " #################################################### Installing logstash ################################################"
echo ''
echo ''
echo ''
cd /opt
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
sudo apt-get install apt-transport-https
echo "deb https://artifacts.elastic.co/packages/8.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-8.x.list
sudo apt-get update && sudo apt-get install logstash
systemctl start logstash
systemctl enable logstash
echo ''
echo ''
echo ''
echo " #################################################### Installing Loki #####################################################"
echo ''
echo ''
echo ''
wget https://github.com/grafana/loki/releases/download/v2.7.0/loki_2.7.0_amd64.deb
chmod +x loki_2.7.0_amd64.deb
dpkg -i loki_2.7.0_amd64.deb
echo ''
echo ''
echo ''
echo " #################################################### Installing Promtail ##################################################"
echo ''
echo ''
echo ''
wget https://github.com/grafana/loki/releases/download/v2.7.0/promtail_2.7.0_amd64.deb
chmod +x promtail_2.7.0_amd64.deb 
dpkg -i promtail_2.7.0_amd64.deb
echo ''
echo ''
echo ''
echo " ################################################### Installing Grafana ####################################################"
echo ''
echo ''
echo ''
sudo apt-get install -y apt-transport-https
sudo apt-get install -y software-properties-common wget
sudo wget -q -O /usr/share/keyrings/grafana.key https://apt.grafana.com/gpg.key
echo "deb [signed-by=/usr/share/keyrings/grafana.key] https://apt.grafana.com stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
sudo apt-get update
sudo apt-get install grafana
systemctl start grafana-server
systemctl enable  grafana-server
cd /etc/logstash/conf.d/
wget https://raw.githubusercontent.com/ro6it/Loki-alb-stack/main/logstash.conf
