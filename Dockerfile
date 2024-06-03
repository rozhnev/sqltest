FROM php:8.3.7-apache

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

RUN apt-get update && apt-get install -y vim libpq-dev \
    && docker-php-ext-install pdo pdo_pgsql 