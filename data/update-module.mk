#Obiba Drupal Modules installation

SHELL := /bin/bash

update-obiba: update-module obiba-clear-cache obiba-js-dependecies obiba-composer-conf  update-db obiba-fix-permission

update-module:
	drush dl -y obiba_bootstrap obiba_mica obiba_agate

update-db:
	drush updatedb
