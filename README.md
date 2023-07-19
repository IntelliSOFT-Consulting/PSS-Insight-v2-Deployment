# PSS-Insight-v2-Deployment

## Deployment Instructions

### Pre-requisites

- OS Architecture: **linux/amd64**  
- Docker and Docker Compose should be installed on your system.

### Step 1: Clone the Repository

 - Clone the repository containing the Docker Compose files to your local environment. There are two folders (`national` & `international` each of which have `docker-compose.yml` files.
 - cd into each folder to start the network setup

### Step 2: Network Setup

Before deploying the services, ensure that the required networks are already created and available in Docker. There are two networks: `d2-cluster-2380_default` and `docker_default` You can create these networks using the following commands:

```
docker network create d2-cluster-2380_default
docker network create docker_default
````

### Step 3: Deploy the Services

Run the following command to deploy all the services defined in the docker-compose.yml file in each folder:

```
docker-compose up -d
```
This will start the containers, allowing them to run in the background.

### Step 4: Verify Deployment

After the deployment is complete, you can check the status of the containers using the following command:

```
docker-compose ps
```

This will display the status of each service, along with their container names and other details.

### Step 5: Clean Up

To stop and remove all the containers while preserving the data volumes, use the following command:
```
docker-compose down
```

To remove the containers as well as the associated data volumes, use the following command:

```
docker-compose down -v
```
