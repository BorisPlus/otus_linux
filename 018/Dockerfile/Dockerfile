FROM alpine
RUN apk add nginx
# Замена дефолтной конфигурации nginx, отдающую всегда "404"
COPY host/default.conf /etc/nginx/http.d/
# Страница приветствия сайта
COPY host/index.html /var/www/default/html/
# Запуск nginx не в режиме демона, чтоб не было Exit(0)
# А как иначе?
CMD ["nginx", "-g", "daemon off;"]
