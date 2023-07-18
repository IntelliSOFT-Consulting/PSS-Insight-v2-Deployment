#!/bin/bash

# build Docker images from Dockerfiles
build_images() {
  echo "Building Docker images..."
  docker build -t dhis2/core:2.38.0 -f Dockerfile-core .
  docker build -t ghcr.io/baosystems/postgis:12-3.3 -f Dockerfile-db .
  docker build -t jwilder/nginx-proxy:alpine -f Dockerfile-gateway .
  docker build -t intellisoftdev/dhis_pss_national:v1 -f Dockerfile-dhis_pss_national .
  docker build -t intellisoftdev/pss_data_sync:latest -f Dockerfile-pss_data_synchronization .
  docker build -t intellisoftdev/pss-survey -f Dockerfile-survey-app .
}

# execute Docker Compose commands
execute_compose() {
  echo "Executing Docker Compose..."
  docker-compose -p d2-cluster-2380 up -d
}

# Main function
main() {
  build_images
  execute_compose
}

# Call the main function
main