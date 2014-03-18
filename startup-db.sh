#/bin/bash

if [ ! -f /var/lib/mysql/ibdata1 ]; then

    mysql_install_db

    /usr/bin/mysqld_safe &
    sleep 3s

    mysql -uroot -e "CREATE USER 'soapower' IDENTIFIED BY 'soapower';"
    mysql -uroor -e "GRANT ALL ON soapower.* TO 'soapower'@'%' IDENTIFIED BY 'soapower';"
    mysql -uroor -e "GRANT ALL ON soapower.* TO 'soapower'@'localhost' IDENTIFIED BY 'soapower';FLUSH PRIVILEGES;"

    killall mysqld
    sleep 3s
fi

/usr/bin/mysqld_safe &
sleep 3s
