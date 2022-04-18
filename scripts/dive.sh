#!/bin/bash

docker run -v /var/run/docker.sock:/var/run/docker.sock jauderho/dive "--ci sample-app:dev" >> sample-app-dev.txt