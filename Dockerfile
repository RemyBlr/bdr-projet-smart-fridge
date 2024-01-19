FROM php:8.2-apache
COPY --from=composer /usr/bin/composer /usr/bin/composer
RUN apt-get update && apt-get -y install libzip-dev libicu-dev libpq-dev
RUN docker-php-ext-install pdo pdo_pgsql zip intl
RUN pecl install xdebug-3.2.0
RUN docker-php-ext-enable xdebug
RUN echo "xdebug.mode=debug" >> /usr/local/etc/php/php.ini
RUN docker-php-ext-install pgsql