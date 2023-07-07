#!/bin/bash

# Start dhis_pss_international service
docker run -d --name dhis_pss_international \
  -e "PATH=/usr/local/openjdk-11/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin" \
  -e "JAVA_HOME=/usr/local/openjdk-11" \
  -e "LANG=C.UTF-8" \
  -e "JAVA_VERSION=11.0.16" \
  -p 7009:7009 \
  intellisoftdev/dhis_pss_international:v3 \
  java -jar target/InternationalInstance.jar

# Start survey service
docker run -d --name survey \
  -e "REACT_APP_API_URL=http://172.104.91.99:7001" \
  -e "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin" \
  -e "NGINX_VERSION=1.25.1" \
  -e "PKG_RELEASE=1" \
  -e "NJS_VERSION=0.7.12" \
  -p 3001:3001 \
  --network=pss-survey_default \
  pss-survey-survey \
  nginx -g "daemon off;"
  
# Stop and remove containers
docker rm -f dhis_pss_international survey
