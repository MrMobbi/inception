
SRCS_PATH	= srcs/

DCOMP_PATH	= srcs/docker-compose.yml

build:
		docker-compose -f $(DCOMP_PATH) build

up:
		docker-compose -f $(DCOMP_PATH) up -d

stop:
		docker-compose -f $(DCOMP_PATH) down

nginx:
		docker exec -it nginx bash

ls:
		docker image ls

clean: 
		docker system prune -a -f
