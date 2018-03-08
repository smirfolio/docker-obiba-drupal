#!/bin/bash

help:
	@echo "make docker-up : Up and run Obiba Drupal Mica portal "
	@echo "make docker-shell : Shell into container"
	@echo "make docker-clear : Stop and remove container"

docker-up:
	export DOCKERHOST=$(route -n | awk '/UG[ \t]/{print $2}')
	docker-compose -f docker-compose.yml up -d --build

docker-shell:
	docker-compose exec drupal bash

docker-clear:
	docker-compose stop && \
	docker-compose down