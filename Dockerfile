# Use an official Ubuntu base image
FROM ubuntu:latest

# Install Nginx, PHP-FPM and recommended PHP modules
RUN apt-get update && \
    apt-get install -y nginx php-fpm php-mysql

# Remove the default Nginx configuration
RUN rm /etc/nginx/sites-enabled/default

# Add custom Nginx config
ADD nginx.conf /etc/nginx/nginx.conf

# Configure PHP-FPM to run in the background
RUN sed -i 's/;daemonize = yes/daemonize = no/' /etc/php/7.4/fpm/php-fpm.conf

# Expose port 80
EXPOSE 80

# Start Nginx and PHP-FPM services
CMD service php7.4-fpm start && nginx -g 'daemon off;'
