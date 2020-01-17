#!/bin/bash

echo HOME:$HOME
EXE=taketa_${NAME}

systemctl stop ${EXE}.service

cat <<EOF>/etc/systemd/system/${EXE}.service
[Unit]
Description=${EXE}

[Service]
User=${USER}
WorkingDirectory=${WD}
ExecStart=/usr/bin/${EXE} ${OPTIONS}
Restart=always

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable ${EXE}.service
systemctl start ${EXE}.service
systemctl status ${EXE}.service

#ps aux | rg ${EXE} 

# For log
#journalctl -f -n 1000 -u ${EXE}
#journalctl -f -u ${EXE}
