FROM drupal:7.57-apache

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
	php composer-setup.php && \
	mv composer.phar /usr/local/bin/composer && \
	php -r "unlink('composer-setup.php');"

RUN wget -O drush.phar https://github.com/drush-ops/drush-launcher/releases/download/0.5.1/drush.phar && \
	chmod +x drush.phar && \
	mv drush.phar /usr/local/bin/drush

RUN rm -rf /var/www/html/*

COPY data/000-default.conf /etc/apache2/sites-enabled/000-default.conf
COPY data/htaccess /var/www/html/.htaccess

# http
EXPOSE 80