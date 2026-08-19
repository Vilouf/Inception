#!/bin/bash
set -e

DB_PASSWORD=$(cat /run/secrets/db_password)
WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password)

echo "Starting WordPress setup..."

cd /var/www/wordpress

if [ ! -f "wp-login.php" ]; then
    echo "Downloading WordPress..."
    wp core download --allow-root
fi

if [ ! -f "wp-config.php" ]; then
    echo "Creating wp-config.php..."
    wp config create \
        --dbname=${SQL_DATABASE} \
        --dbuser=${SQL_USER} \
        --dbpass=${DB_PASSWORD} \
        --dbhost=mariadb:3306 \
        --allow-root

    echo "Waiting for MariaDB to be ready..."
    # Boucle qui patiente tant que MariaDB rejette la connexion
    while ! mariadb -h"mariadb" -u"${SQL_USER}" -p"${DB_PASSWORD}" "${SQL_DATABASE}" -e "SELECT 1;" &> /dev/null; do
        echo "MariaDB is not ready yet, waiting 2 seconds..."
        sleep 2
    done

    echo "MariaDB is up! Installing WordPress..."
    wp core install \
        --url=${DOMAIN_NAME} \
        --title="Inception" \
        --admin_user=${WP_ADMIN_USER} \
        --admin_password=${WP_ADMIN_PASSWORD} \
        --admin_email=${WP_ADMIN_EMAIL} \
        --skip-email \
        --allow-root

    echo "Creating additional user..."
    wp user create \
        ${WP_USER} \
        ${WP_USER_EMAIL} \
        --user_pass=${WP_USER_PASSWORD} \
        --role=author \
        --allow-root
fi

echo "Setting correct permissions..."
chown -R www-data:www-data /var/www/wordpress
chmod -R 755 /var/www/wordpress

echo "WordPress setup complete! Starting PHP-FPM..."
exec /usr/sbin/php-fpm8.2 -F