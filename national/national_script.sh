#!/bin/bash

# Function to check if a command is available or not
function check_command() {
  if ! command -v "$1" &> /dev/null; then
    echo "$1 is not installed. Please install $1 before running this script."
    exit 1
  fi
}

# Check if required commands are available
check_command docker
check_command docker-compose

# Set environment variables for d2-cluster-2380-core-1
CORE_DB_CONTAINER="d2-cluster-2380-db-1"
CORE_DOCKER_IMAGE="dhis2/core:2.38.0"
CORE_DHIS2_HOME="/DHIS2_home"
CATALINA_OPTS="-Dcontext.path='' -Dlog4j2.configurationFile=/DHIS2_home/log4j2.xml"
PATH="/usr/local/tomcat/bin:/usr/local/openjdk-11/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
JAVA_HOME="/usr/local/openjdk-11"
LANG="C.UTF-8"
JAVA_VERSION="11.0.15"
CATALINA_HOME="/usr/local/tomcat"
TOMCAT_NATIVE_LIBDIR="/usr/local/tomcat/native-jni-lib"
LD_LIBRARY_PATH="/usr/local/tomcat/native-jni-lib"
GPG_KEYS="48F8E69F6390C9F25CFEDCD268248959359E722B A9C5DF4D22E99998D9875A5110C01C5A2F6059E7\
        \ DCFD35E0BF8CA7344752DE8B6FB21E8933C60243"
TOMCAT_MAJOR="9"
TOMCAT_VERSION="9.0.62"
TOMCAT_SHA512="179af1d50a7d330d0842d3f1cae086bbc1b20e8f6752d66500663f3ac71d80f50113bbd29931e21c8e2eccd982f9f872e193364311316fdd67349130d440c83f"
WAIT_FOR_DB_CONTAINER=""

# Set environment variables for d2-cluster-2380-db-1
DB_POSTGRES_PASSWORD="dhis"
DB_POSTGRES_DB="dhis2"
DB_POSTGRES_USER="dhis"
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/lib/postgresql/12/bin"
GOSU_VERSION="1.16"
LANG="en_US.utf8"
PG_MAJOR="12"
PG_VERSION="12.14-1.pgdg110+1"
PGDATA="/var/lib/postgresql/data"
POSTGIS_MAJOR="3"
POSTGIS_VERSION="3.3.2+dfsg-1.pgdg110+1"


# Set environment variables for d2-cluster-2380-gateway-1
GATEWAY_DOCKER_IMAGE="jwilder/nginx-proxy:alpine"
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
NGINX_VERSION="1.23.3"
PKG_RELEASE="1"
NJS_VERSION="0.7.9"
NGINX_PROXY_VERSION="1.2.1-14-gabcef6b"
DOCKER_GEN_VERSION="0.10.1"
DOCKER_HOST="unix:///tmp/docker.sock"

# Set environment variables for dhis_pss_national
PSS_NATIONAL_DOCKER_IMAGE="intellisoftdev/dhis_pss_national:v1"
PATH="/usr/local/openjdk-11/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
JAVA_HOME="/usr/local/openjdk-11"
LANG="C.UTF-8"
JAVA_VERSION="11.0.16"


# Set environment variables for pss_data_synchronization
DATA_SYNC_DOCKER_IMAGE="intellisoftdev/pss_data_sync:latest"
SOURCE_USERNAME="admin"
SOURCE_PASSWORD="district"
SOURCE_URL="https://pssnational.intellisoftkenya.com/api/events"
TARGET_USERNAME="admin"
TARGET_PASSWORD="district"
TARGET_URL="https://pssinternational.intellisoftkenya.com/api/events"
SOURCE_DATA_ELEMENTS_URL="https://pssnational.intellisoftkenya.com/api/dataElements"
PATH="/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
LANG="C.UTF-8"
GPG_KEY="E3FF2839C048B25C084DEBE9B26995E310250568"
PYTHON_VERSION="3.9.17"
PYTHON_PIP_VERSION="23.0.1"
PYTHON_SETUPTOOLS_VERSION="58.1.0"
PYTHON_GET_PIP_URL="https://github.com/pypa/get-pip/raw/0d8570dc44796f4369b652222cf176b3db6ac70e/public/get-pip.py"
PYTHON_GET_PIP_SHA256="96461deced5c2a487ddc65207ec5a9cffeca0d34e7af7ea1afc470ff0d746207"

# Set environment variables for survey-app
SURVEY_APP_DOCKER_IMAGE="intellisoftdev/pss-survey"
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
NGINX_VERSION="1.25.1"
PKG_RELEASE="1"
NJS_VERSION="0.7.12"

# Start the services using docker-compose
echo "Starting services using docker-compose..."
docker-compose up -d

# Wait for a while to allow containers to fully start
echo "Waiting for containers to start..."
sleep 10

# Display the running containers
echo "Running containers:"
docker ps


# check if the DHIS2 core server is running before proceeding
echo "Checking if the DHIS2 core server is running..."

while IFS= read -r line; do
    # skip comments
    if [[ $line =~ ^# ]]; then
        continue
    fi
    if [[ $line =~ ^DHIS2_CORE_PORT=(.*)$ ]]; then
        dhis2_port="${BASH_REMATCH[1]}"
    fi
done <./.env

while [[ $(curl -v http://localhost:$dhis2_port>&1) != *"Connected to localhost"* ]]; do
    echo "DHIS2 core server is not running. Waiting for 10 seconds..."
    sleep 10
done

echo "DHIS2 core server is running."

echo "Installing DHIS2 apps..."
cd scripts && ./webapps.sh

echo "Deployment completed successfully!"