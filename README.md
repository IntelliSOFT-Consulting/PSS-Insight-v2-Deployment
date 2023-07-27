# PSS-Insight-v2-Deployment

## Deployment Instructions

### Pre-requisites

- OS Architecture: **linux/amd64. Preferably Ubuntu 20.04LTS and above**  
- **Docker and Docker Compose**. Instructions for installing on an Ubuntu OS can be found here https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-compose-on-ubuntu-22-04
- **NodeJS - minimum version 14**: Instructions for installing NodeJS on an Ubuntu OS can be found here https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-ubuntu-22-04
- **Yarn**: Instructions for installing Yarn can be found here https://classic.yarnpkg.com/lang/en/docs/install
- **Unzip**: You need to have unzip installed on your system.

The installation process involves 2 stages:

1. Deploy DHIS2

2. Deploy PSS v2 WebApps

## 1. Deploy DHIS2

 - Clone this repository into to your local environment 

```git clone https://github.com/IntelliSOFT-Consulting/PSS-Insight-v2-Deployment-national.git```
 - cd into the `national` folder
 - Follow the instructions detailed [here](./national/README.md)

## 2. Deploy PSS v2 Web Apps

The following process will deploy the these custom web apps that are all part of the PSS V2 application:
- [PSS Insight v2 Data entry app](https://github.com/IntelliSOFT-Consulting/PSS-Insight-v2-Dataentry-Dhis2App)
- [PSS Insight v2 Configuration app](https://github.com/IntelliSOFT-Consulting/PSS-Insight-v2-National-Dhis2App)
- [PSS Insight v2 Data Sync app](https://github.com/IntelliSOFT-Consulting/PSS-Insight-v2-Indicator-Sync-Dhis2App)
- [PSS Insight v2 Data Import app](https://github.com/IntelliSOFT-Consulting/PSS-Insight-v2-Data-Import)

#### Pre-requisites

- **DHIS2 Server instance**: Ensure that your instance of DHIS2 is running. Also ensure that you have the URL to the international instance.
- Confirm that the following environment variables have been set correctly in the [.env](./.env) file

| Variable        | Description                                                                              |
|-----------------|------------------------------------------------------------------------------------------|
| SOURCE_USERNAME | URL Path to the national instance e.g.  http://pssnational.intellisoftkenya.com          |
| SOURCE_PASSWORD | DHIS2 username: admin                                                                    |
| SOURCE_URL      | DHIS2 Password: district                                                                 |
| TARGET_URL      | URL Path to the international instance e.g. http://pssinternational.intellisoftkenya.com |

### Deploy
- Ensure that you are inside the `national` folder
- run `sudo chmod 755 ./scripts/webapps.sh` to make the script executable
- run `./scripts/webapps.sh` to deploy the apps to your DHIS2 instance
- Enter the required keys as prompted (You may not be prompted if the keys are found in the [.env](./.env) file)

