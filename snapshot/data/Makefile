#Obiba Drupal Modules installation

SHELL := /bin/bash
#mysql
MYSQL_HOST=172.16.0.6
MYSQL_DATABASE_USER=drupal
MYSQL_PASSWORD=password
MYSQL_DB=drupal_mica
#Drupal
www_folder=/var/www/html
Dadm=administrator
Dpassword=password
www_user="www-data"

build-obiba: site-download site-install obiba-en-dependecies obiba-settings  obiba-composer-conf obiba-fix-permission

site-download:
	drush make -y drupal_snapshot.yml
site-install:
	drush site-install standard --account-name=$(Dadm) --account-pass=$(Dpassword) --db-url=mysql://$(MYSQL_DATABASE_USER):$(MYSQL_PASSWORD)@$(MYSQL_HOST)/$(MYSQL_DB) --site-name="Obiba Mica" install_configure_form.update_status_module='array(FALSE,FALSE)' -y

obiba-en-dependecies:
	drush en -y bootstrap obiba_bootstrap obiba_mica obiba_agate  autologout

obiba-clear-cache:
	drush cc all

obiba-composer-conf:
	drush composer-json-rebuild && \
	pushd  sites/default/files/composer && \
	composer update && \
	composer dump-autoload -o && popd

obiba-fix-permission:
	chown -R $(www_user): *

obiba-settings:
	drush dis -y jquery_update && \
    rm -rf sites/all/modules/jquery_update && \
    drush dl -y jquery_update-7.x-3.0-alpha5 && \
    drush en -y jquery_update && \
    drush en -y obiba_mica && \
    drush ev 'variable_set("theme_obiba_bootstrap_settings", array("jquery_update_jquery_version" => 2.2));' && \
    drush vset -y --format=string jquery_update_jquery_version 2.2 && \
    drush vset -y jquery_update_jquery_migrate_enable 1 && \
	drush vset -y autologout_redirect_url "<front>" && \
	drush vset -y autologout_no_dialog TRUE && \
	drush vset -y --format=string error_level 0 && \
	drush -y updatedb

