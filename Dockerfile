FROM php:8.2-apache

# Встановлюємо розширення PHP
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    && docker-php-ext-configure gd \
    && docker-php-ext-install gd pdo pdo_mysql

# Встановлюємо Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Копіюємо файли проєкту
COPY . /var/www/html

# Встановлюємо права
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Запускаємо сервер
CMD ["apache2-foreground"]
