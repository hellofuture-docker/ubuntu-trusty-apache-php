FROM ubuntu:14.04
MAINTAINER Andy Gale (andy@hellofutu.re)

ENV APACHE_RUN_USER  www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_PID_FILE  /var/run/apache2.pid
ENV APACHE_RUN_DIR   /var/run/apache2
ENV APACHE_LOCK_DIR  /var/lock/apache2
ENV APACHE_LOG_DIR   /var/log/apache2
ENV APACHE_USER_UID 0

RUN apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
		curl apache2-mpm-prefork ca-certificates \
		php5 libapache2-mod-php5 \
		php5-fpm php5-cli php5-mysqlnd php5-pgsql php5-sqlite php5-redis \
		php5-apcu php5-intl php5-imagick php5-mcrypt php5-json php5-gd php5-curl && \
	php5enmod mcrypt && \
	a2enmod rewrite && \
	cd /tmp && curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer && \
	rm -r /var/lib/apt/lists/*

COPY conf/apache2/000-default.conf /etc/apache2/sites-enabled/000-default.conf
COPY conf/php5/php.ini /etc/php5/mods-available/php.ini
COPY scripts/hf-init.bash /root/hf-init.bash

CMD ["/bin/bash", "/root/hf-init.bash"]

EXPOSE 80