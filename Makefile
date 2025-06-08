COMPOSE_FILE=./srcs/docker-compose.yml
PROJECT_NAME=inception

up:
	sudo docker compose -p $(PROJECT_NAME) -f $(COMPOSE_FILE) up -d --build

down:
	suod docker compose -p $(PROJECT_NAME) -f $(COMPOSE_FILE) down -v --remove-orphans

clean:
	sudo docker compose -p $(PROJECT_NAME) -f $(COMPOSE_FILE) down -v --rmi all --remove-orphans

re: clean up

.PHONY: up down clean re

