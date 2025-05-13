# Usa la imagen oficial de PHP con Apache
FROM php:8.2-apache

# Configuración crítica para Render.com
WORKDIR /var/www/html

# Copia los archivos PHP a la imagen
COPY public/ /var/www/html/

# Instala dependencias y extensiones de PHP
RUN apt-get update && \
    apt-get install -y \
    libzip-dev \
    unzip && \
    docker-php-ext-install pdo_mysql zip && \
    a2enmod rewrite

# Configura Apache para Render
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Puerto expuesto (Render usa 10000 para PHP, pero Docker requiere 80)
EXPOSE 80

# Comando de inicio para Apache
CMD ["apache2-foreground"]