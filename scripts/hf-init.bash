#!/bin/bash
set -e

if [ $APACHE_USER_UID != 0 ];then
  usermod -u $APACHE_USER_UID $APACHE_RUN_USER
fi

rm -f /var/run/apache2/apache2.pid

exec apache2 -DFOREGROUND