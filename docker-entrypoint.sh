#!/bin/bash
set -e

if [ "$1" = 'app' ]; then
    exec /var/www/html/start.sh
fi

exec "$@"