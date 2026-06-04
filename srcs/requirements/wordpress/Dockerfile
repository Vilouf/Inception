FROM debian:bookworm

RUN apt update && apt upgrade -y && \
    apt install -y php8.2-fpm php8.2-mysql mariadb-client curl && \
    rm -rf /var/lib/apt/lists/*

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

COPY wordpress_setup.sh /usr/local/bin/wordpress_setup.sh
RUN chmod +x /usr/local/bin/wordpress_setup.sh

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/wordpress_setup.sh"]