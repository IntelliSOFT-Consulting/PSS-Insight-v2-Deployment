# PSS-Insight-v2-Deployment

  
OS Architecture pre-requisite: **linux/amd64**

**Deployment scripts**

- The Docker compose files : ```docker-compose.yaml```  in either of the `national` or `international` folders can be started by running the following command:



```
docker-compose up
```

This will start all of the services in the Docker compose file.

**Bash Scripts**

 1. The script references the relevant Docker Compose files and Dockerfiles which are in the same directory as the script itself. To make the script file executable e.g: `national_script.sh` run `chmod +x national_script.sh` 

The Docker compose file can be stopped by running the following command:

```
docker-compose down
```