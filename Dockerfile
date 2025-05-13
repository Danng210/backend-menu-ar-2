# FROM php:8.2-apache

# # Configuración crítica para Render
# WORKDIR /var/www/html

# # Copia los archivos PHP
# COPY public/ /var/www/html/

# # Instala dependencias y extensiones
# RUN apt-get update && \
#     apt-get install -y \
#     libzip-dev \
#     unzip && \
#     docker-php-ext-install pdo_mysql zip && \
#     a2enmod rewrite

# # Configura Apache para escuchar en todas las interfaces (no en localhost)
# RUN echo "ServerName 0.0.0.0" >> /etc/apache2/apache2.conf && \
#     sed -i 's/Listen 80/Listen 0.0.0.0:80/g' /etc/apache2/ports.conf

# # Puerto expuesto
# EXPOSE 80

# # Comando de inicio
# CMD ["apache2-foreground"]

FROM php:8.2-fpm-alpine

# Configuración crítica para Render
WORKDIR /var/www/html

# Copia los archivos PHP de tu backend
COPY . /var/www/html/

# Instala dependencias y extensiones necesarias de PHP
RUN apk add --no-cache \
    postgresql-dev \
    libzip-dev \
    zip \
    &&  docker-php-ext-install pdo_pgsql pdo_mysql zip \
    &&  docker-php-ext-enable pdo_pgsql pdo_mysql zip

# Instala Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Instala las dependencias de Composer
RUN composer install --no-dev --optimize-autoloader

# Expone el puerto 8000 para FPM
EXPOSE 8000

# Comando para iniciar PHP-FPM
CMD ["php-fpm", "-F"]
