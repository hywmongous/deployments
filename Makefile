PORTAINERPATH=./portainer
WATCHTOWERPATH=./watchtower

.ONESHELL: portainer watchtower
.SILENT:
.PHONY: portainer watchtower

help:
	@echo 'Project targets:'
	@echo '  deploy                        - Deloys the portainer stack'
	@echo '  portainer                     - Deploys the portainer stack'

portainer:
	@echo 'Deploying Portainer'
	sudo docker stack deploy -c $(PORTAINERPATH)/docker-compose.yml portainer
	@echo '  You can now access portainer at https://localhost:9443'

watchtower:
	@echo 'Deploying Watchtower'
	sudo docker stack deploy -c $(WATCHTOWERPATH)/docker-compose.yml watchtower
	@echo '  Watchtower is now polling new images and handles updating'

rm-all:
	sudo docker stack rm $$(sudo docker stack ls --format "{{.Name}}")

rm:
	sudo docker stack rm portainer watchtower

deploy:
	@echo 'Deploying everything'
	$(MAKE) portainer
	$(MAKE) watchtower