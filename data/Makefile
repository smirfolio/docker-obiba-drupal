#Obiba Drupal Modules intalation 

#mysql
MYSQL_DATABASE_USER=root
MYSQL_PASSWORD=1234
MYSQL_DB=drupal_obiba
#Drupal
DV=7.56
DF=drupal-release
Dadm=administrator
Dpassword=password
#obiba
MV=7.x-32.2
AV=7.x-2.4
BV=7.x-4.4

build-obiba: mysql-create site-install obiba-dl-dependecies obiba-en-dependecies obiba-js-dependecies obiba-composer-conf obiba-settings

mysql-create:
	mysql -u $(MYSQL_DATABASE_USER) --password=$(MYSQL_PASSWORD) -e "drop database if exists $(MYSQL_DB); create database $(MYSQL_DB);"

site-install:
	drush site-install standard --account-name=$(Dadm) --account-pass=$(Dpassword) --db-url=mysql://$(MYSQL_DATABASE_USER):$(MYSQL_PASSWORD)@localhost/$(MYSQL_DB) -y

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
	drush vset -y autologout_no_dialog TRUE