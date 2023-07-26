#!/bin/bash

if ! command -v node &>/dev/null; then
    echo "nodejs is not installed. Please install nodejs before running this script."
    exit 1
fi

if ! command -v yarn &>/dev/null; then
    echo "yarn is not installed. Please install yarn before running this script."
    exit 1
fi

if ! command -v git &>/dev/null; then
    echo "git is not installed. Please install git before running this script."
    exit 1
fi

deploy_dhis2_app() {
    echo "Cloning repository from $1"
    git clone "$1"
    app_folder=$(basename "$1" .git)
    cd "$app_folder" || exit 1

    echo "Installing dependencies..."
    yarn install

    echo "Building the app..."
    yarn build

    echo "Deploying the app..."
    yarn deploy $dhis2_url --username $username --password $password

    echo "Cleaning up..."
    cd ..
    rm -rf "$app_folder"

}

read -p "Enter the DHIS2 URL for the national instance: " dhis2_url
if [[ ! $dhis2_url =~ ^https?:// ]]; then
    echo "Invalid URL. Please enter a valid URL."
    exit 1
fi

read -p "Enter your DHIS2 username for the national instance: " username
if [[ -z $username ]]; then
    echo "Username cannot be empty. Please enter a valid username."
    exit 1
fi

read -s -p "Enter your DHIS2 password for the national instance: " password
if [[ -z $password ]]; then
    echo "Password cannot be empty. Please enter a valid password."
    exit 1
fi

read -p "Enter the backend URL for national instance: " backend_url
if [[ ! $backend_url =~ ^https?:// ]]; then
    echo "Invalid URL. Please enter a valid URL."
    exit 1
fi

read -p "Enter the backend URL for the international instance: " dhis2_intl_url
if [[ ! $dhis2_intl_url =~ ^https?:// ]]; then
    echo "Invalid URL. Please enter a valid URL."
    exit 1
fi

# Data entry app
data_entry_app_repo="https://github.com/IntelliSOFT-Consulting/PSS-Insight-v2-Dataentry-Dhis2App.git"
echo "Deploying Data Entry app..."
echo "REACT_APP_NATIONAL_URL=$backend_url" >.env

deploy_dhis2_app "$data_entry_app_repo"

# Configuration app
config_app_repo="https://github.com/IntelliSOFT-Consulting/PSS-Insight-v2-National-Dhis2App.git"
echo "Deploying Configuration app..."
echo "REACT_APP_NATIONAL_URL=$backend_url" >.env
echo "REACT_APP_INTERNATIONAL_URL=$dhis2_intl_url" >>.env

deploy_dhis2_app "$config_app_repo"

# Data import app
data_import_app_repo="https://github.com/IntelliSOFT-Consulting/PSS-Insight-v2-Data-Import.git"
echo "Deploying Data Import app..."
deploy_dhis2_app "$data_import_app_repo"

# Indicator Sync app
indicator_sync_app_repo="https://github.com/IntelliSOFT-Consulting/PSS-Insight-v2-Indicator-Sync-Dhis2App.git"
echo "Deploying Indicator Sync app..."
deploy_dhis2_app "$indicator_sync_app_repo"

echo "All apps deployed successfully!"
