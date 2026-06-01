FROM debian:bookworm

RUN apt update && apt upgrade -y && \
    apt install -y nginx openssl && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/inception.key \
    -out /etc/nginx/ssl/inception.crt \
    -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=ton_login.42.fr"

RUN mkdir -p /var/run/nginx

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]