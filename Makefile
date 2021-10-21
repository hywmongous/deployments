PORTAINERPATH=./portainer

.ONESHELL: portainer
.SILENT:
.PHONY: portainer

help:
	@echo 'Project targets:'
	@echo '  deploy                        - Deloys the portainer stack'
	@echo '  portainer                     - Deploys the portainer stack'

portainer:
	@echo 'Deploying Portainer'
	sudo docker stack deploy -c $(PORTAINERPATH)/docker-compose.yml portainer
	@echo '  You can now access portainer at https://localhost:9443'

deploy:
	$(MAKE) portainer
	@echo 'Deploying everything'