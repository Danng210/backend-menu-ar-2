# Versión base de PHP con Apache
FROM php:8.2-apache

# Configura el directorio de trabajo
WORKDIR /var/www/html

# Copia solo los archivos necesarios (excluye node_modules, .env, etc.)
COPY public/ /var/www/html/

# Instala dependencias del sistema y extensiones PHP
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libzip-dev \
    unzip && \
    docker-php-ext-install \
    pdo_mysql \
    zip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Habilita módulos de Apache necesarios
RUN a2enmod rewrite headers

# Configura el document root de Apache
ENV APACHE_DOCUMENT_ROOT /var/www/html
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# Permisos para archivos (necesario para Apache)
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

# Puerto expuesto (para Railway)
EXPOSE 8080

# Variables de entorno para producción
ENV PHP_OPCACHE_VALIDATE_TIMESTAMPS="1" \
    PHP_OPCACHE_MAX_ACCELERATED_FILES="10000" \
    PHP_OPCACHE_MEMORY_CONSUMPTION="128" \
    PHP_OPCACHE_MAX_WASTED_PERCENTAGE="10"