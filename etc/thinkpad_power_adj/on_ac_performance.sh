export watt_limit=55
export temp_limit=98

./ryzen_apply.sh

cp thinkfan.ac.yaml /etc/thinkfan.yaml
systemctl reload thinkfan
