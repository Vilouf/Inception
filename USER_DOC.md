# User Documentation

## What services are included?

This project provides a small web stack:

- Nginx: serves the website over HTTPS
- WordPress: the application and admin panel
- MariaDB: the database used by WordPress

## Start the project

From the project root:

```bash
make
```

This builds and starts all containers.

## Stop the project

```bash
make down
```

To restart it:

```bash
make restart
```

## Access the website

Open the configured domain in the browser, for example:

```text
https://<your-domain>
```

The default domain is defined in `srcs/.env`.

## Access the administration panel

Use the WordPress admin page:

```text
https://<your-domain>/wp-admin
```

Use the credentials defined in the environment and secret files.

## Where are the credentials?

- Environment variables: `srcs/.env`
- Secrets: `secrets/`

Examples of generated files:

- `secrets/db_password.txt`
- `secrets/db_root_password.txt`
- `secrets/wp_user_password.txt`
- `secrets/wp_admin_password.txt`

## Check if the services are running

```bash
docker ps
make logs
```

If containers are running correctly, you should see the nginx, wordpress, and mariadb containers in Docker.
