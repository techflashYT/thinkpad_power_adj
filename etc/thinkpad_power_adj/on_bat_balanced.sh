export watt_limit=10
export temp_limit=60

./ryzen_apply.sh

cp thinkfan.bat.yaml /etc/thinkfan.yaml
systemctl reload thinkfan
