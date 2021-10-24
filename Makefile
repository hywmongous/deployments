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

rm-all:
	sudo docker stack rm $$(sudo docker stack ls --format "{{.Name}}")

rm:
	sudo docker stack rm portainer

deploy:
	@echo 'Deploying everything'
	$(MAKE) portainer
