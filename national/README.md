# DHIS2 Dockerized Server
<!-- TOC -->
* [DHIS2 Dockerized Server](#dhis2-dockerized-server)
  * [Pre-requisites](#pre-requisites)
  * [Basic Setup](#basic-setup)
    * [Seeding](#seeding)
    * [Start the services](#start-the-services)
  * [Configuration and Logs](#configuration-and-logs)
  * [Additional commands](#additional-commands)
  * [Advanced Usage](#advanced-usage)
    * [Multiple backend instances](#multiple-backend-instances)
  * [Accessing your new server](#accessing-your-new-server)
<!-- TOC -->
## Pre-requisites

* In case you missed them, check out the previous steps [here](../README.md#1-deploy-dhis2)
* **OPTIONAL** A DHIS2 database `.sql` or `.sql.gz` dump compatible with the version of DHIS2 you will be installing (see db/backup.2023.07.26.sql.gz))

## Basic Setup
### Seeding
First, seed the database with some dummy data (**optional**):

```bash
> ./scripts/seed.sh db/backup.2023.07.26.sql.gz
```

**Note** that once the server is up and running you will need to export Analytics Tables in the [Data Administration app](http://localhost:8080/dhis-web-data-administration/index.action#/analytics).  This must be run as a system user and can take some time to complete.

### Start the services

Once the containers have been built and the database seeded you can start the cluster:

```bash
> ./scripts/start.sh
```

_(it may take a couple minutes for the Java server to initialize)_


Once started, the services should automatically restart if Docker or the host machine are restarted.

Your DHIS2 instance will be accessible at [localhost:8080](http://localhost:8080/) on the server. 

Deploy the PSS v2 Web Apps. Follow the instructions [here](../README.md#2-deploy-pss-insight-v2-web-apps)

---
## Configuration and Logs

The `DHIS2_home` directory on the `core` container is mapped to the directory `./config/DHIS2_home`, so you can put configuration there as well as view DHIS2 system logs.  This directory is **NOT** deleted when running `clean.sh`.  The `dhis.conf` file is required to exist and by default has the following contents (note the database connection parameters):

```conf
connection.dialect = org.hibernate.dialect.PostgreSQLDialect
connection.driver_class = org.postgresql.Driver
connection.url = jdbc:postgresql://db/dhis2
connection.username = dhis
connection.password = dhis
# Database schema behavior, can be validate, update, create, create-drop
connection.schema = update

encryption.password = xxxx
metadata.audit.persist = on
```

---
## Additional commands
You can stop the services manually:

```bash
> ./scripts/stop.sh
```

Or destroy the Docker images and all database data (which is stored in a Docker-managed [volume](https://docs.docker.com/storage/volumes/) on the host system):

```bash
> ./scripts/clean.sh
```

## Advanced Usage

By default, `start.sh` will pull the image [amcgee/dhis2-core:dev-alpine](https://hub.docker.com/r/amcgee/dhis2-core/tags/) from Docker Hub.  You can specify a custom image tag (though not a custom image at this time) with the environment variable `DHIS2_CORE_TAG`, for example:

```sh
> DHIS2_CORE_TAG=2.31-rc1-alpine ./scripts/start.sh
```

By default, `start.sh` will expose the DHIS2 Core instance at port 8080.  This can be customized with the environment variable `DHIS2_CORE_PORT`, for example:

```sh
> DHIS2_CORE_PORT=8888 ./scripts/start.sh
```

These environment variables can also be specified int the `.env` file

### Multiple backend instances

It is possible to run multiple instances of the DHIS2 backend cluster on the same machine.  Since `docker-compose` uses the name of the directory as the project namespace for a cluster, it is currently necessary to keep separate copies of the `dhis2-backend` repo with different directory names, such as `backend` and `backend-231rc1`.  With this setup and using the environment variables above to select a core version tag and specify non-conflicting ports it is possibel to run multiple versions of the backend simultaneously.

## Accessing your new server

Once the container is running:

* Your DHIS2 instance will be accessible at [localhost:8080](http://localhost:8080/)
