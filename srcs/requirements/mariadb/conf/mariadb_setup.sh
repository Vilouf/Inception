#!/bin/sh

mkdir -p /run/mysqld /var/lib/mysql
chown -R mysql:mysql /run/mysqld /var/lib/mysql

if [ ! -d "/var/lib/mysql/${SQL_DATABASE}" ]; then

    mysql_install_db --user=mysql --datadir=/var/lib/mysql

    mysqld_safe --user=mysql --datadir=/var/lib/mysql --bind-address=0.0.0.0 &
    
    until mysqladmin ping 2>/dev/null; do
        sleep 1
    done

    mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
    mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
    mysql -e "CREATE USER IF NOT EXISTS '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
    mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO '${SQL_USER}'@'%';"
    mysql -e "FLUSH PRIVILEGES;"

    mysqladmin -u root -p"${SQL_ROOT_PASSWORD}" shutdown
fi

exec mysqld_safe --user=mysql --datadir=/var/lib/mysql --bind-address=0.0.0.0