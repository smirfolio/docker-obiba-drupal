#Obiba Drupal Modules intalation 

SHELL := /bin/bash
#mysql
MYSQL_HOST=db
MYSQL_DATABASE_USER=root
MYSQL_PASSWORD=1234
MYSQL_DB=drupal_obiba
#Drupal
www_folder=/var/www/html
DF=drupal-release
Dadm=administrator
Dpassword=password
#obiba
MV=7.x-32.2
AV=7.x-2.4
BV=7.x-4.4
www_user="www-data"

build-obiba: site-install obiba-dl-dependecies obiba-en-dependecies obiba-js-dependecies obiba-composer-conf obiba-settings obiba-fix-permission

site-install:
	drush site-install standard --account-name=$(Dadm) --account-pass=$(Dpassword) --db-url=mysql://$(MYSQL_DATABASE_USER):$(MYSQL_PASSWORD)@$(MYSQL_HOST)/$(MYSQL_DB) --site-name="Obiba Mica" -y

obiba-dl-dependecies:
	drush dl -y bootstrap obiba_bootstrap-$(BV) obiba_mica-$(MV) obiba_agate-$(AV)  autologout

obiba-en-dependecies:
	drush en -y bootstrap obiba_bootstrap obiba_mica obiba_agate  autologout

obiba-clear-cache:
	drush cc all

obiba-js-dependecies:
	drush download-mica-dependencies

obiba-composer-conf:
	drush composer-json-rebuild && \
	pushd  sites/default/files/composer && \
	composer update && \
	composer dump-autoload -o && popd

obiba-settings:
	drush vset -y --format=string jquery_update_jquery_version 1.10 && \
	drush vset -y --format=string jquery_update_jquery_admin_version 1.10 && \
	drush vset -y autologout_redirect_url "<front>" && \
	drush vset -y autologout_no_dialog TRUE && \
	drush vset -y mica_url https://dockerhost:8445

obiba-fix-permission:
	chown -R $(www_user): *


