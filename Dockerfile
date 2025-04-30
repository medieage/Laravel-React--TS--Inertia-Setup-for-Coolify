FROM php:8.2-fpm

# Installing basic dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    libzip-dev \
    nginx \
    supervisor \
    libpq-dev  # Dependency for PostgreSQL

# Installing PHP extensions
RUN docker-php-ext-install pdo_pgsql pgsql mbstring exif pcntl bcmath gd zip

# Installing Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Installing Node.js 18.x
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g npm

# Configuring PHP-FPM to use unix socket
RUN mkdir -p /var/run && \
    sed -i 's/listen = 9000/listen = \/var\/run\/php-fpm.sock/g' /usr/local/etc/php-fpm.d/www.conf && \
    sed -i 's/;listen.owner = www-data/listen.owner = www-data/g' /usr/local/etc/php-fpm.d/www.conf && \
    sed -i 's/;listen.group = www-data/listen.group = www-data/g' /usr/local/etc/php-fpm.d/www.conf && \
    sed -i 's/;listen.mode = 0660/listen.mode = 0660/g' /usr/local/etc/php-fpm.d/www.conf

# Working directory
WORKDIR /var/www/html

# Copying project files
COPY . /var/www/html/

# Configuring Nginx
COPY docker/nginx.conf /etc/nginx/sites-available/default
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

# Creating .env file if it doesn't exist
RUN if [ ! -f .env ]; then \
    touch .env; \
    fi

# Preparing storage directories and adding .gitkeep files
RUN mkdir -p storage/framework/sessions \
    && mkdir -p storage/framework/views \
    && mkdir -p storage/framework/cache \
    && mkdir -p storage/logs \
    && mkdir -p bootstrap/cache \
    && touch storage/framework/sessions/.gitkeep \
    && touch storage/framework/views/.gitkeep \
    && touch storage/framework/cache/.gitkeep \
    && touch storage/logs/.gitkeep \
    && touch bootstrap/cache/.gitkeep \
    && mkdir -p storage/app/public \
    && touch storage/app/public/.gitkeep \
    && chmod -R 777 storage \
    && chmod -R 777 bootstrap/cache \
    && chown -R www-data:www-data storage \
    && chown -R www-data:www-data bootstrap/cache

# Installing PHP dependencies
RUN composer install --no-dev --optimize-autoloader --no-interaction

# Installing NPM dependencies and building for production
RUN npm ci && npm run build

# Creating directory for supervisord
RUN mkdir -p /var/log/supervisor

# Configuring Supervisor to run PHP-FPM, Nginx and Laravel
COPY docker/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Exposing ports
EXPOSE 80 9000

# Run command
CMD cd /var/www/html && \
    php artisan config:clear && \
    php artisan storage:link && \
    php artisan cache:clear && \
    php artisan route:clear && \
    php artisan view:clear || true && \
    php artisan optimize && \
    /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
