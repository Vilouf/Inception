FROM debian:bookworm

RUN apt update && apt upgrade -y && \
    apt install -y php8.2-fpm php8.2-mysql mariadb-client curl && \
    rm -rf /var/lib/apt/lists/*

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# --- LIGNES À AJOUTER ICI 👇 ---
# On crée le dossier pour que PHP-FPM puisse stocker son PID
RUN mkdir -p /run/php
# On remplace l'écoute sur le socket par l'écoute sur le port 9000 dans la config de pool par défaut
RUN sed -i 's/listen = \/run\/php\/php8.2-fpm.sock/listen = 9000/g' /etc/php/8.2/fpm/pool.d/www.conf
# -------------------------------

COPY wordpress_setup.sh /usr/local/bin/wordpress_setup.sh
RUN chmod +x /usr/local/bin/wordpress_setup.sh

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/wordpress_setup.sh"]