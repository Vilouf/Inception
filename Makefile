NAME = inception
COMPOSE_FILE = srcs/docker-compose.yml
SECRETS_DIR = secrets

-include srcs/.env
VOLUMES_DIR ?= /home/pespana/data

GREEN = \033[1;32m
RED = \033[1;31m
BLUE = \033[1;34m
RESET = \033[0m

all: setup secrets up

up: setup secrets
	@echo "$(BLUE)Building and starting containers...$(RESET)"
	docker compose -f $(COMPOSE_FILE) up -d --build

down:
	@echo "$(BLUE)Stopping containers...$(RESET)"
	docker compose -f $(COMPOSE_FILE) down

restart: down up

logs:
	docker compose -f $(COMPOSE_FILE) logs -f

setup:
	@mkdir -p $(VOLUMES_DIR)/mariadb
	@mkdir -p $(VOLUMES_DIR)/wordpress
	@if [ ! -f "srcs/.env" ]; then \
		echo "$(RED)Error: srcs/.env file not found.$(RESET)"; \
		echo "$(BLUE)Generating srcs/.env from srcs/.env.example...$(RESET)"; \
		if [ -f "srcs/.env.example" ]; then \
			cp srcs/.env.example srcs/.env; \
			echo "$(GREEN)srcs/.env created. Please fill in your values and run make again.$(RESET)"; \
		else \
			echo "$(RED)srcs/.env.example not found either. Please create srcs/.env manually.$(RESET)"; \
		fi; \
		exit 1; \
	fi

secrets:
	@if [ ! -d "$(SECRETS_DIR)" ]; then \
		echo "$(GREEN)Genererating secrets in $(SECRETS_DIR)...$(RESET)"; \
		mkdir -p $(SECRETS_DIR); \
		openssl rand -hex 64 | tr -d '\n' > $(SECRETS_DIR)/db_password.txt; \
		openssl rand -hex 64 | tr -d '\n' > $(SECRETS_DIR)/db_root_password.txt; \
		openssl rand -hex 64 | tr -d '\n' > $(SECRETS_DIR)/wp_admin_password.txt; \
		echo "$(GREEN)Secrets generated successfully.$(RESET)"; \
	else \
		echo "$(BLUE)Secrets directory already exists. Skipping generation.$(RESET)"; \
	fi

clean: down
	@echo "$(BLUE)Cleaning stopped containers...$(RESET)"
	docker compose -f $(COMPOSE_FILE) down --remove-orphans --rmi all

fclean: clean
	@echo "$(RED)Cleaning up project...$(RESET)"
	docker compose -f $(COMPOSE_FILE) down -v
	@echo "$(RED)Removing secrets directory...$(RESET)"
	rm -rf $(SECRETS_DIR)
	@echo "$(RED)Removing volumes directory...$(RESET)"
	sudo rm -rf $(VOLUMES_DIR)

re: fclean all

.PHONY: all up down restart setup secrets clean fclean re