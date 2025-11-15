FROM php:8.3-apache
# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    zip \
    unzip \
    ssh

# WORK DIR

WORKDIR /var/www/html/

RUN docker-php-ext-install mysqli pdo_mysql && docker-php-ext-enable mysqli

# Install Composer globally
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer 

RUN composer create-project laravel/laravel travellist

# COPY . /var/www/html/
RUN chmod -R 777 /var/www/html/travellist
RUN a2enmod rewrite
# RUN a2ensite travellist.conf
# RUN a2dissite 000-default.conf
COPY .env /var/www/html/travellist/

EXPOSE 80