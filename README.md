<img width="627" alt="image" src="https://github.com/IntelliSOFT-Consulting/PSS-Insight-v2-Deployment-national/assets/1963527/18869ea8-90c4-4fb7-86b5-57cc33ed3fdc"># PSS-Insight-v2-Deployment

## Deployment Instructions

### Pre-requisites

- OS Architecture: **linux/amd64**  
- Docker and Docker Compose should be installed on your system. Instructions for installing on an Ubuntu OS can be found here https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-compose-on-ubuntu-22-04

### Step 1: Clone the Repository

 - Clone this repository into to your local environment
 - cd into the `national` folder to start the network setup

### Step 2: See below
 - Follow the instructions detailed [here](./national/README.md)

### Step 3: Deploy custom apps

### Pre-requisites

DHIS2 Server: You need to have a running DHIS2 instance accessible over the internet.
NodeJS: You need to have NodeJS V 14+ installed on your system. Instructions for installing NodeJS on an Ubuntu OS can be found here https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-ubuntu-22-04
Yarn: You need to have Yarn installed on your system. Instructions for installing Yarn can be found here https://classic.yarnpkg.com/lang/en/docs/install

- #### Data entry app
1. clone the [data entry app repository](https://github.com/IntelliSOFT-Consulting/PSS-Insight-v2-Dataentry-Dhis2App.git) into your local environment
2. cd into the `PSS-Insight-v2-Dataentry-Dhis2App` folder
3. run `yarn install` to install the dependencies
4. go to `src/api/api.js` and change the `baseURL` to point to your DHIS2 instance
5. run `yarn build` to build the app
6. run `yarn deploy` to deploy the app to your DHIS2 instance. You will be prompted to enter your DHIS2 credentials. Enter them and press enter. The app will be deployed to your DHIS2 instance.

- #### Configuration app
1. clone the [configuration app repository](https://github.com/IntelliSOFT-Consulting/PSS-Insight-v2-National-Dhis2App.git)
2. cd into the `PSS-Insight-v2-National-Dhis2App` folder
3. run `yarn install` to install the dependencies
4. go to `src/api/api.js` and change the `baseURL` for `api` to point to your DHIS2 instance and the `baseURL` for `apiInternational` to point to the international instance
5. run `yarn build` to build the app
6. run `yarn deploy` to deploy the app to your DHIS2 instance. You will be prompted to enter your DHIS2 credentials. Enter them and press enter. The app will be deployed to your DHIS2 instance.

- #### Data import app
1. clone the [data import app repository](https://github.com/IntelliSOFT-Consulting/PSS-Insight-v2-Data-Import.git)
2. cd into the `PSS-Insight-v2-Data-Import` folder
3. run `yarn install` to install the dependencies
4. run `yarn build` to build the app
5. run `yarn deploy` to deploy the app to your DHIS2 instance. You will be prompted to enter your DHIS2 credentials. Enter them and press enter. The app will be deployed to your DHIS2 instance.

- #### Indicator Sync app
1. clone the [indicator sync app repository](https://github.com/IntelliSOFT-Consulting/PSS-Insight-v2-Indicator-Sync-Dhis2App.git)
2. cd into the `PSS-Insight-v2-Indicator-Sync-Dhis2App` folder
3. run `yarn install` to install the dependencies
4. run `yarn build` to build the app
5. run `yarn deploy` to deploy the app to your DHIS2 instance. You will be prompted to enter your DHIS2 credentials. Enter them and press enter. The app will be deployed to your DHIS2 instance.

