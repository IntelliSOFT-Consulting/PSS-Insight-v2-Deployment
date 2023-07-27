# PSS-Insight-v2-Deployment

## Deployment Instructions

### Pre-requisites

- OS Architecture: **linux/amd64**
- Docker and Docker Compose should be installed on your system. Instructions for installing on an Ubuntu OS can be found here https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-compose-on-ubuntu-22-04

### Step 1: Clone the Repository

- Clone this repository into to your local environment
- cd into the `national` folder to start the network setup

### Step 2: Deployment via Docker

- Follow the instructions detailed [here](./national/README.md)

### Step 3: Deploy custom apps

#### Pre-requisites

DHIS2 Server: You need to have a running DHIS2 instance accessible over the internet.
NodeJS: You need to have NodeJS V 14+ installed on your system. Instructions for installing NodeJS on an Ubuntu OS can be found here https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-ubuntu-22-04
Yarn: You need to have Yarn installed on your system. Instructions for installing Yarn can be found here https://classic.yarnpkg.com/lang/en/docs/install
Unzip: You need to have unzip installed on your system.

#### Required keys

| Field                                                | Description                                               | Example                                       |
| ---------------------------------------------------- | --------------------------------------------------------- | --------------------------------------------- |
| Enter the DHIS2 URL for the national instance        | The URL of the DHIS2 instance you're deploying the app to | http://pssnational2.intellisoftkenya.com      |
| Enter your DHIS2 username for the national instance  | The username of the DHIS2 instance                        | admin                                         |
| Enter your DHIS2 password for the national instance  | The password of the DHIS2 instance                        | district                                      |
| Enter the backend URL for the international instance | The URL of the backend of international instance          | https://pss-insight-backend-international.com |

#### .env file setup
| Field                                                | Description                                               | Example                                       |
| ---------------------------------------------------- | --------------------------------------------------------- | --------------------------------------------- |
| SOURCE_URL                                           | The URL of the DHIS2 instance you're deploying the app to | http://pssnational2.intellisoftkenya.com/api/events     |
| SOURCE_USERNAME                                      | The username of the DHIS2 instance                        | admin                                         |
| SOURCE_PASSWORD                                      | The password of the DHIS2 instance                        | district                                      |
| TARGET_URL                                           | The URL of the backend of international instance          | https://pss-insight-backend-international.com/api/events |
| DHIS2_DATA_ENTRY_RELEASE_URL                         | The URL to the release of the DHIS2 data entry app (zip)  | https://github.com/IntelliSOFT-Consulting/PSS-Insight-v2-Dataentry-Dhis2App/archive/refs/tags/V1.0.0.zip |
| DHIS2_CONFIGURATION_RELEASE_URL                     | The URL to the release of the DHIS2 configuration app (zip)| https://github.com/IntelliSOFT-Consulting/PSS-Insight-v2-National-Dhis2App/archive/refs/tags/v1.0.0.zip |
| DHIS2_DATA_IMPORT_RELEASE_URL                          | The URL to the release of the DHIS2 data import app (zip)  | https://github.com/IntelliSOFT-Consulting/PSS-Insight-v2-Data-Import/archive/refs/tags/v1.0.0.zip |
| DHIS2_INDICATOR_SYNC_RELEASE_URL                       | The URL to the release of the DHIS2 indicator sync app (zip)  | https://github.com/IntelliSOFT-Consulting/PSS-Insight-v2-Indicator-Sync-Dhis2App/archive/refs/tags/v1.0.0.zip |


> Note: 

 - You have to include the `http://` or `https://` protocol in the URLs
 - The URLs should point to the zip files of the apps. 
 - Only add the urls for the apps you want to deploy. If you don't want to deploy an app, leave the field for that app blank.
 - At least one app must be deployed. Failure to deploy at least one app will result in an error. 

### Deploy

- cd into the `national/scripts/` folder
- run `sudo chmod 755 ./webapps.sh` to make the script executable
- run `./webapps.sh` to deploy the apps to your DHIS2 instance
- Enter the required keys as prompted. (You may not be prompted if the keys are found in the `.env` file)
