#!/bin/bash
if [ ! -f /.db_created ]; then
	/create_db.sh
	touch /.db_created
fi

echo "=> Starting mysqld"
/startup-db.sh
echo "=> Starting soapower"
/opt/soapower/current/soapowerctl.sh start
