#!/bin/bash
help:
	@echo "make docker-up : Up and run Obiba Drupal Mica portal "
	@echo "make docker-shell : Shell into container"
	@echo "make docker-clear : Stop, remove images and prune network"
	@echo "make docker-remove-container : remove container"

docker-up:
	docker-compose -f docker-compose.yml up -d --build

docker-shell:
	docker-compose exec docker-obiba-drupal bash

docker-logs:
	docker-compose logs -f | grep drupal

docker-clear:
	docker-compose stop && \
	docker-compose down && \
	docker network prune -f && \
	docker rmi -f `docker images -q`

docker-remove-container:
	docker rm -f `docker ps -a -q`
