#!/bin/bash

docker build -t webapps:latest -f ./Dockerfile_webapps .

docker run --rm --name webapps -t webapps:latest
