#!/bin/bash

/etc/init.d/mariadb start

echo "CREATE DATABASE IF NOT EXISTS $SQL_NAME ;" > db.sql
echo "CREATE USER IF NOT EXISTS '$SQL_USER'@'%' IDENTIFIED BY '$SQL_PWD' ;" >> db.sql
echo "GRANT ALL PRIVILEGES ON $SQL_NAME.* TO '$SQL_USER'@'%' ;" >> db.sql
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '1234' ;" >> db.sql
echo "FLUSH PRIVILEGES;" >> db.sql

/usr/bin/mysql < db.sql

mysqladmin -u root -p$SQL_ROOT_PWD shutdown

exec "$@"
