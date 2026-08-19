FROM debian:bookworm

RUN apt update && apt install -y \
    mariadb-server \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/mysqld \
    && chown mysql:mysql /var/run/mysqld

COPY mariadb_setup.sh /mariadb_setup.sh
RUN chmod +x /mariadb_setup.sh

EXPOSE 3306

ENTRYPOINT ["/mariadb_setup.sh"]