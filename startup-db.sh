#/bin/bash

if [ ! -f /var/lib/mysql/ibdata1 ]; then

    mysql_install_db

    /usr/bin/mysqld_safe &
    sleep 10s

    echo "CREATE USER 'soapower'@'locahost' IDENTIFIED BY 'soapower';" | mysql -uroot
	echo "GRANT ALL PRIVILEGES ON 'soapower'.* TO 'soapower'@'localhost' IDENTIFED BY 'soapower';" | mysql -uroot
    killall mysqld
    sleep 10s
fi

/usr/bin/mysqld_safe &