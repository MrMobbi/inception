
VOLUME_PATH	= /home/mjulliat/data

DCOMP_PATH	= srcs/docker-compose.yml

all:	build up

build:	create_folder_data
		docker-compose -f $(DCOMP_PATH) build

create_folder_data:
		mkdir -p $(VOLUME_PATH)/wordpress
		mkdir -p $(VOLUME_PATH)/mariadb

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
		docker ps
		docker volume ls

clean:	stop
		docker system prune -a -f

fclean: clean clean_volumes

clean_volumes:
		docker volume rm $$(docker volume ls -q);
		rm -rf $(VOLUME_PATH)/mariadb
		rm -rf $(VOLUME_PATH)/wordpress

re:		fclean all
