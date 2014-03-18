#!/bin/bash

echo "=> Starting mysql database"
/usr/bin/mysqld_safe&
sleep 10

echo "=> Creating database"
RET=1
while [[ RET -ne 0 ]]; do
	sleep 5
	mysql -uroot -e "CREATE DATABASE soapower CHARACTER SET utf8 COLLATE utf8_general_ci;"
	RET=$?
done

mysqladmin -uroot shutdown

echo "=> Done!"
