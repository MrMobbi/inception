#!/bin/bash

while ! mariadb -h $SQL_HOST -u $SQL_USER -p $SQL_PWD $SQL_NAME &>/dev/null; do
  sleep 3
done

if [ ! -e ./var/www/html/wp-config.php ]
then

    # installation of CLI [inteface textuel pour ligne de commande]
    wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar

    # installing wordpress
    ./wp-cli.phar core download http://wordpress.org/latest.tar.gz \
                                --allow-root \
                                --path='/var/www/html'
    
  ./wp-cli.phar config create --allow-root \
                              --dbname=${SQL_NAME} \
                              --dbuser=${SQL_USER} \
                              --dbpass=${SQL_PWD} \
                              --dbhost=${SQL_HOST} \
                              --dbcharset="utf8" \
                              --dbcollate="utf8_general_ci" \
                              --path='/var/www/html'
  
  sleep 10

  # Second page
  ./wp-cli.phar core install --allow-root \
                             --url=${WP_SITE_URL} \
                             --title=${WP_SITE_TITLE} \
                             --admin_user=${WP_ADMIN_USER} \
                             --admin_password=${WP_ADMIN_PWD} \
                             --admin_email=${WP_ADMIN_EMAIL} \
                             --skip-email \
                             --path='/var/www/html'

  sleep 10

  # Create user
  ./wp-cli.phar user create --allow-root \
                            --role=author ${WP_USER} ${WP_USER_EMAIL} \
                            --user_pass=${WP_USER_PWD} \
                            --path='/var/www/html'

    chmod 775 /var/www/html/*
fi

exec "$@"
