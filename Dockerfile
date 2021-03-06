#
# Mica Drupal client Dockerfile
#
# https://github.com/obiba/docker-mica-drupal
#

FROM drupal:7.73

MAINTAINER OBiBa <dev@obiba.org>

RUN apt-get update && apt-get install -y curl default-mysql-client wget

#
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (hash_file('sha384', 'composer-setup.php') === '795f976fe0ebd8b75f26a6dd68f78fd3453ce79f32ecb33e7fd087d39bfeb978342fb73ac986cd4f54edd0dc902601dc') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
	php composer-setup.php && \
	mv composer.phar /usr/local/bin/composer && \
	php -r "unlink('composer-setup.php');"

# Install Drush
RUN composer global require drush/drush:8.* && \
  	ln -s /root/.composer/vendor/bin/drush /usr/local/bin/drush && \
  	drush dl composer-8.x-1.x && \
  	drush status

COPY data/000-default.conf /etc/apache2/sites-enabled/000-default.conf
COPY data/20.memory_limit.ini /usr/local/etc/php/conf.d/
COPY data/Makefile /var/www/html/Makefile
# They be usuful if we want to update some already installed obiba_mica modules
COPY data/update-module.mk /var/www/html/update-module.mk
COPY bin/start.sh /var/www/html/start.sh
RUN ["chmod", "+x", "/var/www/html/start.sh"]


# Update self contained composer for php-7.3
COPY data/composer.json /root/.drush/composer
RUN cd /root/.drush/composer && \
  	composer update && \
  	drush composer about

ENV MYSQL_HOST=172.16.0.6
ENV MYSQL_DATABASE=drupal_mica
ENV MYSQL_USER=drupal
ENV MYSQL_PASSWORD=password
ENV MYSQL_ROOT_PASSWORD=password
ENV AGATE_PORT_8444_TCP_ADDR=172.16.0.1
ENV AGATE_PORT=8444
ENV MICA_PORT_8445_TCP_ADDR=172.16.0.1
ENV MICA_PORT=8445
# http
EXPOSE 80

# Define default command.
COPY ./docker-entrypoint.sh /
RUN ["chmod", "+x", "/docker-entrypoint.sh"]
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["app"]
