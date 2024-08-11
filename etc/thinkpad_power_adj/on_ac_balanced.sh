export watt_limit=40
export temp_limit=70

./ryzen_apply.sh

cp thinkfan.ac.yaml /etc/thinkfan.yaml
systemctl reload thinkfan
