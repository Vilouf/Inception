#!/bin/sh

while ! mysqladmin ping -h"mariadb" -u"${SQL_USER}" -p"${SQL_PASSWORD}" --silent; do
    sleep 1
done

mkdir -p /run/php
sed -i 's|listen = /run/php/php8.2-fpm.sock|listen = 0.0.0.0:9000|g' /etc/php/8.2/fpm/pool.d/www.conf

mkdir -p /var/www/wordpress
cd /var/www/wordpress

if [ ! -f "wp-config.php" ]; then

    wp core download --allow-root

    wp config create --allow-root \
        --dbname="${SQL_DATABASE}" \
        --dbuser="${SQL_USER}" \
        --dbpass="${SQL_PASSWORD}" \
        --dbhost=mariadb:3306

    wp core install --allow-root \
        --url="https://${USER}.42.fr" \
        --title="Inception 42" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_EMAIL}"

    wp user create --allow-root \
        "${WP_USER}" "${WP_EMAIL}" \
        --user_pass="${WP_PASSWORD}" \
        --role=author
fi

chown -R www-data:www-data /var/www/wordpress

exec php-fpm8.2 -F