PORTAINERPATH=./portainer
JAEGER=./jaeger
GRAFANA=./grafana
PROMETHEUS=./prometheus
KAFKA=./kafka
INFLUXDB=./influxdb
TRAEFIK=./traefik

.ONESHELL: dev-min dev edge management analytics monitoring streaming tracing timeseries
.PHONY: dev-min dev edge management analytics monitoring streaming tracing timeseries
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

management:
	@echo 'Deploying "management": Portainer'
	docker stack deploy -c $(PORTAINERPATH)/docker-compose.yml management
	@echo '  You can now access Portainer at http://localhost:9000'

analytics:
	@echo 'Deploying "analytics": grafana'
	docker stack deploy -c $(GRAFANA)/docker-compose.yml analytics
	@echo '  You can now access Grafana at http://localhost:3000'

monitoring:
	@echo 'Deploying "monitoring": Prometheus'
	docker stack deploy -c $(PROMETHEUS)/docker-compose.yml monitoring
	@echo '  You can now access Prometheus at http://localhost:9090'
	@echo '  You can now access Node Exporter at http://localhost:9100/metrics'
	@echo '  You can now access Cadvisor at http://localhost:8085'

streaming:
	@echo 'Deploying "streaming": Kafka'
	docker stack deploy -c $(KAFKA)/docker-compose.yml streaming
	@echo '  You can now access Kafka-UI at http://localhost:8081'

tracing:
	@echo 'Deploying "tracing": Jaeger'
	docker stack deploy -c $(JAEGER)/docker-compose.yml tracing
	@echo '  You can now access Jaeger at http://localhost:16686'

timeseries:
	@echo 'Deploying "time series": InfluxDB'
	docker stack deploy -c $(INFLUXDB)/docker-compose.yml timeseries
	@echo '  You can now access Chronograph at http://localhost:8889'

edge:
	@echo 'Deploying "edge": Traefik'
	docker stack deploy -c $(TRAEFIK)/docker-compose.yml edge
	@echo '   You can now access Traefik at http://localhost:8080'
	@echo '   You can now access "whoami" http://whoami.localhost'

dev-min: streaming

dev: management monitoring streaming tracing timeseries analytics edge

rm:
	docker stack rm $$(docker stack ls --format "{{.Name}}")