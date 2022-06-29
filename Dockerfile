FROM nginx

RUN apt update && apt upgrade zlib1g -y

COPY index.html /usr/share/nginx/html/