# PSS-Insight-v2-Deployment

Deployment scripts

  

- The Docker compose file :  ```pss-docker-compose.yaml```  can be started by running the following command:

```
docker-compose up

```

This will start all of the services in the Docker compose file. 

Note:
-   The Docker compose file and the .env file need to be in the same directory.
-   The .env file needs to have the environment variables defined.
-   The Docker compose file needs to have the correct image names and ports defined.

The Docker compose file can be stopped by running the following command:

```
docker-compose down
```
