# PSS-Insight-v2-Deployment

## Table of contents

<!-- TOC -->

* [PSS-Insight-v2-Deployment](#pss-insight-v2-deployment)
  * [Table of contents](#table-of-contents)
  * [Pre-requisites](#pre-requisites)
    * [Basic Installation Steps](#basic-installation-steps)
  *  [Advanced Installation steps](#advanced-installation-steps)
    * [1. Deploy DHIS2](#1-deploy-dhis2)
    * [2. Deploy PSS Insight v2 Web Apps](#2-deploy-pss-insight-v2-web-apps)
      * [Pre-requisites](#pre-requisites-1)
      * [Run deployment script](#run-deployment-script)

<!-- TOC -->

## Pre-requisites

- OS Architecture: **linux/amd64. Preferably Ubuntu 20.04LTS and above**
- **Docker and Docker Compose**. Instructions for installing on an Ubuntu OS can be found here: 
Docker: https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-22-04
Docker-compose: https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-compose-on-ubuntu-22-04. If installing docker-compose for the first time on your server, ensure that it has been registered on the system application directory `/usr/bin/` otherwise, you will run into this error `docker-compose: command not found` if you run docker-compose via `sudo`.

`sudo ln -s ~/.docker/cli-plugin/docker-compose /usr/bin/docker-compose`

- **NodeJS - minimum version 14**: Instructions for installing NodeJS on an Ubuntu OS can be found here https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-ubuntu-22-04
- **Yarn**: Instructions for installing Yarn can be found here https://classic.yarnpkg.com/lang/en/docs/install
- **Unzip**: You need to have unzip installed on your system. `sudo apt install unzip`
- **Git**: Ensure that git installed on your system by running `git -v`. If not installed, install it by running `sudo apt install git`


## Basic Installation Steps

The basic installation process below will use default parameters to perform the following actions under the hood:

* Deploy DHIS2
* Deploy PSS Insight v2 WebApps

The steps are outlined below:

1. Clone the project repository
   ```
     git clone https://github.com/IntelliSOFT-Consulting/PSS-Insight-v2-Deployment-national.git
   ```
2. cd into the project directory
   ```
     cd PSS-Insight-v2-Deployment-national/national
   ```
3. Countercheck the environment variables have been set correctly. They can be found here on the [.env](./.env) file. (Refer to the advanced installation steps on the next section for details about the environment variables)

4. Make the installation script executable
   ```
     sudo chmod 755 ./national_script.sh
   ```
4. Run the installation script
   ```
     ./national_script.sh
   ```

*The process will run for a few minutes.*

Once the process concludes, the application will accessible via the [http://localhost:8080](http://localhost:8080/) link

## Advanced Installation steps

The installation process involves 2 stages:

1. Deploy DHIS2
2. Deploy PSS Insight v2 WebApps

## Installation steps

#### 1. Deploy DHIS2

- Clone this repository into to your local environment

``git clone https://github.com/IntelliSOFT-Consulting/PSS-Insight-v2-Deployment-national.git``

- cd into the `national` folder
- Follow the instructions detailed [here](./national/README.md)

#### 2. Deploy PSS Insight v2 Web Apps

The following process will deploy the these custom web apps that are all part of the PSS V2 application:

- [PSS Insight v2 Data entry app](https://github.com/IntelliSOFT-Consulting/PSS-Insight-v2-Dataentry-Dhis2App)
- [PSS Insight v2 Configuration app](https://github.com/IntelliSOFT-Consulting/PSS-Insight-v2-National-Dhis2App)
- [PSS Insight v2 Data Sync app](https://github.com/IntelliSOFT-Consulting/PSS-Insight-v2-Indicator-Sync-Dhis2App)
- [PSS Insight v2 Data Import app](https://github.com/IntelliSOFT-Consulting/PSS-Insight-v2-Data-Import)

##### Pre-requisites

- **DHIS2 Server instances**:
  - Ensure that your national instance of DHIS2 is running (This is the instance just installed).
  - Ensure that you have the URL to the international instance.
- Confirm that the following environment variables have been set correctly in the [.env](./national/.env) file

#### .env file setup

| Variable                         | Description                                                                                                   |
| -------------------------------- | ------------------------------------------------------------------------------------------------------------- |
| SOURCE_USERNAME                  | URL Path to the national instance e.g.  http://pssnational.intellisoftkenya.com                               |
| SOURCE_PASSWORD                  | DHIS2 username: admin                                                                                         |
| SOURCE_URL                       | DHIS2 Password: district                                                                                      |
| TARGET_URL                       | URL Path to the international instance e.g. http://pssinternational.intellisoftkenya.com                      |
| DHIS2_DATA_ENTRY_RELEASE_URL     | https://github.com/IntelliSOFT-Consulting/PSS-Insight-v2-Dataentry-Dhis2App/archive/refs/tags/V1.0.0.zip      |
| DHIS2_CONFIGURATION_RELEASE_URL  | https://github.com/IntelliSOFT-Consulting/PSS-Insight-v2-National-Dhis2App/archive/refs/tags/v1.0.0.zip       |
| DHIS2_DATA_IMPORT_RELEASE_URL    | https://github.com/IntelliSOFT-Consulting/PSS-Insight-v2-Data-Import/archive/refs/tags/v1.0.0.zip             |
| DHIS2_INDICATOR_SYNC_RELEASE_URL | https://github.com/IntelliSOFT-Consulting/PSS-Insight-v2-Indicator-Sync-Dhis2App/archive/refs/tags/v1.0.0.zip |

> Note:

- You have to include the `http://` or `https://` protocol in the URLs
- The URLs should point to the zip files of the apps.
- Only add the urls for the apps you want to deploy. If you don't want to deploy an app, leave the field for that app blank.
- At least one app must be deployed. Failure to deploy at least one app will result in an error.

### Deploy

##### Run the app deployment script

- cd into the scripts folder. `cd scripts/`
- run `sudo chmod 755 ./webapps.sh` to make the script executable
- run `./webapps.sh` to deploy the apps to your DHIS2 instance
- Enter the required keys as prompted (You may not be prompted if the keys are found in the [.env](./national/.env) file)

*This process will take a few minutes to complete as the apps are built and deployed*
