#!/bin/bash

# Configure database
if [ -n $MYSQL_HOST ]
	then
	# Wait for MySQL to be ready
	until mysql -h $MYSQL_HOST -u $MYSQL_USER -p$MYSQL_PASSWORD -e ";" &> /dev/null
	do
	  sleep 1
	done
    INSTALLED=`drush status bootstrap | grep -o 'Successful'`
#	echo "Installed : $INSTALLED   ---   $(drush status bootstrap | grep -o 'Successful')"
	if [[ "$INSTALLED" =~ "Successful" ]]
	 then
        echo "Drupal installed "
    else
        cd /var/www/html && \
	    make build-obiba && \

	     # Drupal settings
        if [ ! -z $BASE_URL ]
            then
            echo '$base_url = "'$BASE_URL'";' >> /var/www/html/sites/default/settings.php
        fi

        cd /var/www/html && \
          chown -R www-data:www-data .

        # Set mica_url and agate url
        if [ -n $MICA_PORT_8445_TCP_ADDR ]
            then
            cd /var/www/html && \
              drush vset -y mica_url https://$MICA_PORT_8445_TCP_ADDR:$MICA_PORT
          fi

          if [ -n $AGATE_PORT_8444_TCP_ADDR ]
            then
            cd /var/www/html && \
              drush vset -y agate_url https://$AGATE_PORT_8444_TCP_ADDR:$AGATE_PORT
          fi

	fi


fi

apache2-foreground