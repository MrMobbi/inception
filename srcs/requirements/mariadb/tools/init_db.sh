#!/bin/sh

service mariadb start

echo "CREATE DATABASE IF NOT EXISTS $SQL_NAME;" > db.sql
echo "CREATE USER IF NOT EXISTS '$SQL_USER'@'%' IDENTIFIED BY '$SQL_PWD';" >> db.sql
echo "GRANT ALL PRIVILEGES ON $SQL_NAME.* TO '$SQL_USER'@'%';" >> db.sql
echo "FLUSH PRIVILEGES;" >> db.sql

mariadb < db.sql

echo "coucou"

service mariadb stop

echo "coucou 2"

exec "$@"
