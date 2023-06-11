FROM nginx:1.24.0-alpine
COPY ./public/web/ /usr/share/nginx/html