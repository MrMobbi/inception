
SRCS_PATH	= srcs/

DCOMP_PATH	= srcs/docker-compose.yml

build:
		docker-compose -f $(DCOMP_PATH) build

up:
		docker-compose -f $(DCOMP_PATH) up -d

stop:
		docker-compose -f $(DCOMP_PATH) down

ng:
		docker exec -it nginx bash

db:
		docker exec -it mariadb bash

wp:
		docker exec -it wordpress bash

ls:
		docker image ls

clean: 
		docker system prune -a -f
