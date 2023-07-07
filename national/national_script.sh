#!/bin/bash

# Start dhis_pss_national service
docker run -d --name dhis_pss_national \
  -e "PATH=/usr/local/openjdk-11/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin" \
  -e "JAVA_HOME=/usr/local/openjdk-11" \
  -e "LANG=C.UTF-8" \
  -e "JAVA_VERSION=11.0.16" \
  -p 7001:7001 \
  intellisoftdev/dhis_pss_national:v1 \
  java -jar target/PssNationalInstance.jar

# Wait for dhis_pss_national service to start
sleep 10

# Start pss_data_synchronization service
docker run -d --name pss_data_synchronization \
  -e "SOURCE_USERNAME=admin" \
  -e "SOURCE_PASSWORD=district" \
  -e "SOURCE_URL=https://pssnational.intellisoftkenya.com/api/events" \
  -e "TARGET_USERNAME=admin" \
  -e "TARGET_PASSWORD=district" \
  -e "TARGET_URL=https://pssinternational.intellisoftkenya.com/api/events" \
  -e "SOURCE_DATA_ELEMENTS_URL=https://pssnational.intellisoftkenya.com/api/dataElements" \
  -e "PATH=/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin" \
  -e "LANG=C.UTF-8" \
  -e "GPG_KEY=E3FF2839C048B25C084DEBE9B26995E310250568" \
  -e "PYTHON_VERSION=3.9.17" \
  -e "PYTHON_PIP_VERSION=23.0.1" \
  -e "PYTHON_SETUPTOOLS_VERSION=58.1.0" \
  -e "PYTHON_GET_PIP_URL=https://github.com/pypa/get-pip/raw/0d8570dc44796f4369b652222cf176b3db6ac70e/public/get-pip.py" \
  -e "PYTHON_GET_PIP_SHA256=96461deced5c2a487ddc65207ec5a9cffeca0d34e7af7ea1afc470ff0d746207" \
  -p 8000:8000 \
  intellisoftdev/pss_data_sync:latest \
  cron -f

# Stop and remove containers
docker rm -f dhis_pss_national pss_data_synchronization