FROM nginx

RUN apt update && apt upgrade zlib1g -y && apt-get clean

COPY index.html /usr/share/nginx/html/