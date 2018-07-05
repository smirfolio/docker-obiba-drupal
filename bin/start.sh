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

cd /var/www/html && \
  chown -R www-data:www-data .

apache2-foreground