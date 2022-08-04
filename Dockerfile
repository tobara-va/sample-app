FROM nginx:latest

RUN apt-get update && apt-get upgrade -y && apt-get clean

COPY index.html /usr/share/nginx/html/