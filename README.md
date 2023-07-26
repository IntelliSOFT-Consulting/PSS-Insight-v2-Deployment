# PSS-Insight-v2-Deployment

## Deployment Instructions

### Pre-requisites

- OS Architecture: **linux/amd64**  
- Docker and Docker Compose should be installed on your system. Instructions for installing on an Ubuntu OS can be found here https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-compose-on-ubuntu-22-04

### Step 1: Clone the Repository

 - Clone this repository into to your local environment
 - cd into the `national` folder to start the network setup
 - Follow the instructions detailed [here](./national/README.md)
   
### Step 2: Network Setup

Before deploying the services, ensure that the required networks are already created and available in Docker. There are two networks: `d2-cluster-2380_default` and `docker_default` You can create these networks using the following commands:

