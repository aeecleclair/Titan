FROM nginx:1.28.0-alpine
COPY nginx.conf /etc/nginx/nginx.conf
COPY ./build/web/ /app/html