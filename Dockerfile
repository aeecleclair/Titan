FROM nginx:1.28.0-alpine3.21-slim
COPY nginx.conf /etc/nginx/nginx.conf
COPY ./build/web/ /app/html
RUN find /app/html/ -type f -regex '.*\.\(html\|css\|js\|json\|svg\|ttf\|otf\|wasm\|mjs\|symbols\)' -exec gzip -k6 {} +