PORTAINERPATH=./portainer
JAEGER=./jaeger
GRAFANA=./grafana
PROMETHEUS=./prometheus
KAFKA=./kafka

.ONESHELL: dev-min dev portainer grafana prometheus kafka jaeger
.PHONY: dev-min dev portainer grafana prometheus kafka jaeger
.SILENT: rm

help:
	@echo 'Deployments:'
	@echo '  dev                           - Deloys the stacks used for development'
	@echo 'Stack targets:'
	@echo '  portainer                     - Deploys the portainer stack'
	@echo '  grafana                       - Deploys the graphana stack'
	@echo '  prometheus                    - Deploys the prometheus stack'
	@echo '  kafka                         - Deploys the kafka stack'
	@echo '  jaeger                        - Deploys the jaeger stack'
	@echo 'Utilities:'
	@echo '  rm                            - Removes all stacks'

portainer:
	@echo 'Deploying Portainer'
	docker stack deploy -c $(PORTAINERPATH)/docker-compose.yml management
	@echo '  You can now access Portainer at http://localhost:9000'

grafana:
	@echo 'Deploying grafana'
	docker stack deploy -c $(GRAFANA)/docker-compose.yml analytics
	@echo '  You can now access Grafana at http://localhost:3000'

prometheus:
	@echo 'Deploying Prometheus'
	docker stack deploy -c $(PROMETHEUS)/docker-compose.yml monitoring
	@echo '  You can now access Prometheus at http://localhost:9090'
	@echo '  You can now access Node Exporter at http://localhost:9100/metrics'
	@echo '  You can now access Cadvisor at http://localhost:8080'

kafka:
	@echo 'Deploying Kafka'
	docker stack deploy -c $(KAFKA)/docker-compose.yml streaming
	@echo '  You can now access Kafka-UI at http://localhost:8081'

jaeger:
	@echo 'Deploying Jaeger'
	docker stack deploy -c $(JAEGER)/docker-compose.yml tracing
	@echo '  You can now access Jaeger at http://localhost:16686'

dev-min: kafka

dev: portainer prometheus kafka jaeger grafana

rm:
	docker stack rm $$(docker stack ls --format "{{.Name}}")