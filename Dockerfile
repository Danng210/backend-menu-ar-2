FROM php:8.2-apache

# Configuración crítica para Render
WORKDIR /var/www/html

# Copia los archivos PHP
COPY public/ /var/www/html/

# Instala dependencias y extensiones
RUN apt-get update && \
    apt-get install -y \
    libzip-dev \
    unzip && \
    docker-php-ext-install pdo_mysql zip && \
    a2enmod rewrite

# Configura Apache para escuchar en todas las interfaces (no en localhost)
RUN echo "ServerName 0.0.0.0" >> /etc/apache2/apache2.conf && \
    sed -i 's/Listen 80/Listen 0.0.0.0:80/g' /etc/apache2/ports.conf

# Puerto expuesto
EXPOSE 80

# Comando de inicio
CMD ["apache2-foreground"]