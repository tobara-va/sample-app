#!/bin/bash
export TAG=$(grep 'Welcome to nginx ' index.html | awk '{print $4}' | awk -F '!' '{print $1}')

echo ${TAG}

