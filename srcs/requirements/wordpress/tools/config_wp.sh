#!/bin/bash

sleep 10

if [ ! -e ./wp-config.php ]
then

    # installation of CLI [inteface textuel pour ligne de commande]
    wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar

    # installing wordpress
    ./wp-cli.phar core download http://wordpress.org/latest.tar.gz \
    --allow-root \
    --path='./'
fi

exec "$@"
