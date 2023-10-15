FROM nginx:1.24.0-alpine
COPY nginx.conf /etc/nginx/nginx.conf
COPY ./public/web/ /usr/share/nginx/html