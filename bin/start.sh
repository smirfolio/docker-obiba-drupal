#!/bin/bash

# Configure database
if [ -n $MYSQL_HOST ]
	then
	# Wait for MySQL to be ready
	until mysql -h $MYSQL_HOST -u root -p$MYSQL_PASSWORD -e ";" &> /dev/null
	do
	  sleep 1
	done

	cd /var/www/html && \
	    make build-obiba

fi

 # Drupal settings
if [ ! -z $BASE_URL ]
	then
   	echo '$base_url = "'$BASE_URL'";' >> /var/www/html/sites/default/settings.php
fi

cd /var/www/html && \
  chown -R www-data:www-data .

# Set mica_url and agate url
if [ -n $MICA_PORT ]
  	then
  	cd /var/www/html && \
  	  drush vset -y mica_url https://$MICA_ADDR:$MICA_PORT
  fi

  if [ -n $AGATE_PORT ]
  	then
  	cd /var/www/html && \
  	  drush vset -y agate_url https://$AGATE_ADDR:$AGATE_PORT
  fi

apache2-foreground