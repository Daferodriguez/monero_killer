#! /bin/bash
cat > /usr/bin/monero_killer.sh <<'endmsg'
#! /bin/bash
i=1;
while sleep 5; 
echo $i;
i=$((i+1));
do 
	sudo docker rm -f $(sudo docker ps -a -q --filter name="sa_bank*" --format="{{.ID}}");
	sudo docker rmi $(sudo docker images |grep "sa_bank*");
done
endmsg

chmod +x /usr/bin/monero_killer.sh


echo "[Unit]
Description=My Script

[Service]
Type=simple
ExecStart=/usr/bin/monero_killer.sh

[Install]
WantedBy=multi-user.target" > /lib/systemd/system/moneroKiller.service
systemctl daemon-reload
systemctl restart moneroKiller
systemctl enable moneroKiller
