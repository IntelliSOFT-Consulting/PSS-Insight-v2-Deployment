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

if ! command -v unzip &>/dev/null; then
    echo "unzip is not installed. Please install unzip before running this script."
    exit 1
fi


node_version=$(node -v)
if [[ $node_version =~ ^v([0-9]+)\. ]]; then
    node_major_version="${BASH_REMATCH[1]}"
    if [[ $node_major_version -lt 14 ]]; then
        echo "node version must be >= 14. Please update node before running this script."
        exit 1
    fi
fi

# check if you are currently in scripts folder 
if [[ ! $(pwd) =~ scripts$ ]]; then
    echo "Please cd into the scripts folder to run this script."
    exit 1
fi

deploy_dhis2_app() {
    echo "Downloading the release..."

    # download the release zip file
    curl -L -o app.zip "$1"

    # extract the zip file
    unzip -q app.zip

    # get the app folder name: check any folder that starts with PSS
    app_folder=$(find . -maxdepth 1 -type d -name "PSS*" -print -quit)

    echo "Extracted the release to $app_folder"

    # remove the zip file
    rm app.zip

    # change directory to the app folder
    cd "$app_folder" || exit

    # create a .env file
    echo "REACT_APP_NATIONAL_URL=$dhis2_url" >.env
    echo "REACT_APP_INTERNATIONAL_URL=$dhis2_intl_url" >>.env

    # install dependencies, build and deploy the app
    echo "Installing dependencies..."
    yarn install --silent

    echo "Building the app..."
    yarn build

    echo "Deploying the app..."
    yarn deploy $dhis2_url --username $username --password $password

    echo "Cleaning up..."
    cd ..
    rm -rf "$app_folder"
}

# initialize empty variables
dhis2_url=""
username=""
password=""
dhis2_intl_url=""

while IFS= read -r line; do
    if [[ $line =~ ^SOURCE_URL=(.*)$ ]]; then
        dhis2_url="${BASH_REMATCH[1]%/api/*}"
    elif [[ $line =~ ^SOURCE_USERNAME=(.*)$ ]]; then
        username="${BASH_REMATCH[1]}"
    elif [[ $line =~ ^SOURCE_PASSWORD=(.*)$ ]]; then
        password="${BASH_REMATCH[1]}"
    elif [[ $line =~ ^TARGET_URL=(.*)$ ]]; then
        dhis2_intl_url="${BASH_REMATCH[1]%/api/*}"
    fi
done <../.env

# ask for the DHIS2 URL if it is not set in the .env file
if [[ -z $dhis2_url ]]; then
    read -p "Enter the DHIS2 URL for the national instance: " dhis2_url
    if [[ ! $dhis2_url =~ ^https?:// ]]; then
        echo "Invalid URL. Please enter a valid URL."
        exit 1
    fi
fi

# ask for the DHIS2 username if it is not set in the .env file
if [[ -z $username ]]; then
    read -p "Enter your DHIS2 username for the national instance: " username
    if [[ -z $username ]]; then
        echo "Username cannot be empty. Please enter a valid username."
        exit 1
    fi
fi

# ask for the DHIS2 password if it is not set in the .env file
if [[ -z $password ]]; then

    read -s -p "Enter your DHIS2 password for the national instance: " password
    if [[ -z $password ]]; then
        echo "Password cannot be empty. Please enter a valid password."
        exit 1
    fi
fi

# ask for the DHIS2 URL if it is not set in the .env file
if [[ -z $dhis2_intl_url ]]; then
    echo ""
    read -p "Enter the DHIS2 URL for the international instance: " dhis2_intl_url
    if [[ ! $dhis2_intl_url =~ ^https?:// ]]; then
        echo "Invalid URL. Please enter a valid URL."
        exit 1
    fi
fi

# Data entry app
data_entry_app_repo="https://github.com/IntelliSOFT-Consulting/PSS-Insight-v2-Dataentry-Dhis2App/archive/refs/tags/V1.0.0.zip"
echo "Deploying Data Entry app..."

deploy_dhis2_app "$data_entry_app_repo"

# Configuration app
config_app_repo="https://github.com/IntelliSOFT-Consulting/PSS-Insight-v2-National-Dhis2App/archive/refs/tags/v1.0.0.zip"
echo "Deploying Configuration app..."

deploy_dhis2_app "$config_app_repo"

# Data import app
data_import_app_repo="https://github.com/IntelliSOFT-Consulting/PSS-Insight-v2-Data-Import/archive/refs/tags/v1.0.0.zip"
echo "Deploying Data Import app..."
deploy_dhis2_app "$data_import_app_repo"

# Indicator Sync app
indicator_sync_app_repo="https://github.com/IntelliSOFT-Consulting/PSS-Insight-v2-Indicator-Sync-Dhis2App/archive/refs/tags/v1.0.0.zip"
echo "Deploying Indicator Sync app..."
deploy_dhis2_app "$indicator_sync_app_repo"

echo "All apps deployed successfully!"
