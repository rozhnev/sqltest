FROM php:8.3.7-apache

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

COPY sqltest.conf /etc/apache2/sites-enabled/000-default.conf

RUN apt-get update && apt-get install -y unzip vim libpq-dev libpng-dev libjpeg-dev libfreetype6-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo pdo_pgsql gd
RUN a2enmod rewrite