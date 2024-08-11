export watt_limit=20
export temp_limit=80

./ryzen_apply.sh

cp thinkfan.bat.yaml /etc/thinkfan.yaml
systemctl reload thinkfan
