FROM alpine:3.14.0
RUN apk add php
RUN apk add php-fpm
# 172.16.1.7:9000 - Где работает php-fpm
RUN sed -i "s@127.0.0.1:9000@172.16.1.7:9000@g" /etc/php7/php-fpm.d/www.conf
# В целях безопасности только 172.16.1.2 может обратиться к php-fpm
RUN sed -i "s@;listen.allowed_clients = 127.0.0.1@listen.allowed_clients = 172.16.1.2@g" /etc/php7/php-fpm.d/www.conf
COPY host/index.php /var/www/default/html/
# Запуск НЕ в режиме демона
CMD ["/usr/sbin/php-fpm7", "-F", "-c", "/etc/php7/php-fpm.conf"]
