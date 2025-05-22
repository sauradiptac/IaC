#!/bin/bash

# Assign parameters
RESOURCE_GROUP=$1 # 1st parameter declared in the calling file (YAML)
LOCATION=$2 # 2nd parameter declared in the calling file (YAML)

# Check if resource group exists
RG_EXISTS=$(az group exists --name "$RESOURCE_GROUP")

if [ "$RG_EXISTS" == "false" ]; then
    echo "Creating resource group: $RESOURCE_GROUP in $LOCATION"
    az group create --name "$RESOURCE_GROUP" --location "$LOCATION"
else
    echo "Resource group $RESOURCE_GROUP already exists."
fi
