#/bin/bash

export HOME=/opt/zabbix

if [ $# -ne 2 ]
then
    # Fix the exit code to zabbix standards
    echo "Wrong Parameter number"
    exit 1
fi

URL="http://localhost:$1/$2"

wget -qO - $URL
