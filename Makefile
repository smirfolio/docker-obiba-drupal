#!/bin/bash
SUBNET=172.20.0.0/16
CGETWAY=172.20.0.1
help:
	@echo "make docker-up : Up and run Obiba Drupal Mica portal "
	@echo "make docker-shell : Shell into container"
	@echo "make docker-clear : Stop and remove container"

docker-up:
	docker network create --driver=bridge --subnet=$(SUBNET) --gateway=$(CGETWAY) drupalNet && \
	docker-compose -f docker-compose.yml up -d --build

docker-shell:
	docker-compose exec docker-obiba-drupal bash

docker-logs:
	docker-compose logs -f

docker-clear:
	docker-compose stop && \
	docker-compose down && \
	docker network prune -f