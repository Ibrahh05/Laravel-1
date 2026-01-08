# 1. Usar la imagen oficial de PHP 8.2 con FPM
FROM php:8.2-fpm 

# 2. Instalar dependencias del sistema y extensiones de PHP necesarias para Laravel y PostgreSQL
RUN apt-get update && apt-get install -y \ 
    git curl zip unzip libpng-dev libonig-dev libxml2-dev libzip-dev libicu-dev libpq-dev \ 
    nodejs npm \ 
    && docker-php-ext-install pdo pdo_mysql pdo_pgsql mbstring zip exif pcntl gd intl \ 
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# 3. Instalar Composer desde la imagen oficial
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# 4. Establecer el directorio de trabajo
WORKDIR /var/www 

# 5. Copiar los archivos del proyecto al contenedor
COPY . . 

# 6. Instalar dependencias de PHP (incluyendo dev para que funcionen los Seeds y Tests si los usas)
RUN composer install --optimize-autoloader --no-interaction

# 7. Instalar dependencias de Node y compilar los archivos de Vite/Mix
RUN npm install 
RUN npm run build 

# 8. Ajustar permisos correctamente para Render
# www-data es el usuario por defecto de PHP en Docker
RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache \
    && chmod -R 775 /var/www/storage /var/www/bootstrap/cache

# 9. Informar el puerto (aunque Render usa la variable $PORT, es buena práctica)
EXPOSE 10000

# 10. COMANDO FINAL (Corregido)
# - Forzamos la migración de la base de datos.
# - Iniciamos el servidor en el puerto que Render nos asigne ($PORT).
CMD php artisan migrate --force && php artisan serve --host=0.0.0.0 --port=$PORT
