This project has been created as part of the 42 curriculum by vielblin.

# Inception

## Description

This project sets up a small web stack with Docker containers for:
- Nginx
- WordPress
- MariaDB

The goal is to learn how to build a containerized architecture using Docker Compose, custom Docker images, separate services, persistent data, and secure configuration.

The project contains a Docker setup under `srcs/` with the service definitions, Dockerfiles, and environment configuration. It also includes a `Makefile` to simplify setup and lifecycle commands.

### Docker design choices

- Virtual Machines vs Docker: Docker is lighter than full VMs because containers share the host OS kernel and are faster to start and easier to isolate.
- Secrets vs Environment Variables: secrets are better for sensitive values such as database and admin passwords because they are stored outside the usual environment and are safer to handle.
- Docker Network vs Host Network: a Docker network isolates services and lets them communicate through a private internal network, which is cleaner and safer than exposing everything on the host.
- Docker Volumes vs Bind Mounts: volumes are easier to manage in Docker, while bind mounts are useful when data must be stored in a specific host folder. In this project, data is persisted on the host with bind-mounted directories.

## Instructions

### Prerequisites

- Docker
- Docker Compose
- A Unix-like environment

### Setup

1. Copy the sample environment file:
   ```bash
   cp srcs/.env.example srcs/.env
   ```
2. Edit `srcs/.env` if needed.
3. Run:
   ```bash
   make
   ```

This builds the containers, creates required folders, and generates secrets automatically.

### Useful commands

```bash
make up
make down
make restart
make logs
make clean
make fclean
```

The stack is available through the configured domain name, usually over HTTPS on port 443.

## Resources

- Docker documentation: https://docs.docker.com/
- Docker Compose documentation: https://docs.docker.com/compose/
- Nginx documentation: https://nginx.org/en/docs/
- MariaDB documentation: https://mariadb.org/documentation/
- WordPress documentation: https://wordpress.org/documentation/

### AI usage

AI was used to help understand the project requirements, explain Docker concepts, and draft the project documentation. It was mainly used for structure, troubleshooting, and writing clear explanations for the setup and configuration steps.
