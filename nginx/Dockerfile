FROM nginx:1.11.5

COPY nginx.conf /etc/nginx/nginx.conf

COPY ./conf.d/viva.conf /etc/nginx/conf.d/nginx.conf

RUN useradd -u 41311 -U -d /tmp -s /bin/bash srv-viva-web
