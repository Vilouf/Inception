# Developer Documentation

## Prerequisites

- Docker
- Docker Compose
- Make
- A Linux environment or WSL/Linux host

## Environment setup

1. Copy the default environment file:
   ```bash
   cp srcs/.env.example srcs/.env
   ```
2. Edit `srcs/.env` with the correct domain and project values.
3. Run:
   ```bash
   make
   ```

This step creates the necessary data folders and generates secret files in `secrets/` if they do not already exist.

## Build and launch the project

From the repository root:

```bash
make up
```

Useful commands:

```bash
make down
make restart
make logs
make clean
make fclean
```

## Container and volume management

List running containers:

```bash
docker ps
```

Inspect services and logs:

```bash
docker compose -f srcs/docker-compose.yml ps
docker compose -f srcs/docker-compose.yml logs -f
```

Check Docker volumes:

```bash
docker volume ls
docker inspect <volume_name>
```

## Data persistence

The project stores data on the host in:

- `/home/vielblin/data/wordpress`
- `/home/vielblin/data/mariadb`

The secret files are stored in:

```text
./secrets/
```

This keeps WordPress files and the MariaDB database persistent between container restarts.
