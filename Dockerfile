FROM php:8.2-apache

# Configuración crítica para Railway
WORKDIR /var/www/html
COPY public/ /var/www/html/
RUN docker-php-ext-install pdo_mysql && a2enmod rewrite

# Puerto y ajustes de Apache
EXPOSE 8080
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf