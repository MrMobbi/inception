#!/bin/bash

sleep 10

if [ ! -f /var/www/html/wp-config.php ]; then

  curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
  chmod 777 wp-cli.phar && \
  #me executable dans /bin car PATH dans ENV
  mv wp-cli.phar /usr/local/bin/wp && \
  cd /var/www/html && \

   # installing wordpress
  wp core download http://wordpress.org/latest.tar.gz \
                   --allow-root \
                   --path='/var/www/html'

  echo "coucou"

  wp config create --allow-root \
                   --dbname=$SQL_NAME \
                   --dbuser=$SQL_USER \
                   --dbpass=$SQL_PWD \
                   --dbhost="mariadb" \
                   --dbcharset="utf8" \
                   --dbcollate="utf8_general_ci" \
                   --path='/var/www/html'


  # Second page
  wp core install --allow-root \
                  --url=$WP_SITE_URL \
                  --title=$WP_SITE_TITLE \
                  --admin_user=$WP_ADMIN_USER \
                  --admin_password=$WP_ADMIN_PWD \
                  --admin_email=$WP_ADMIN_EMAIL \
                  --skip-email \
                  --path='/var/www/html'


  # Create user
  wp user create --allow-root \
                 --role=author $WP_USER $WP_USER_EMAIL \
                 --user_pass=$WP_USER_PWD \
                 --path='/var/www/html'

  chmod 775 /var/www/html/*

fi

exec "$@"
