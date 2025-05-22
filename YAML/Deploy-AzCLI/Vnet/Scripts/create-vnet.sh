#!/bin/bash

RESOURCE_GROUP=$1
VNET_NAME=$2
LOCATION=$3
ADDRESS_RANGE=$4

echo "Checking if Virtual Network '$VNET_NAME' exists in Resource Group '$RESOURCE_GROUP'..."
VNET_EXISTS=$(az network vnet show --resource-group "$RESOURCE_GROUP" --name "$VNET_NAME" --query "name" --output tsv || echo "notfound")

if [ "$VNET_EXISTS" == "notfound" ]; then
  echo "Creating Virtual Network: $VNET_NAME in Resource Group: $RESOURCE_GROUP"
  az network vnet create --name "$VNET_NAME" --resource-group "$RESOURCE_GROUP" --location "$LOCATION" --address-prefixes $ADDRESS_RANGE

  # Set pipeline variable dynamically
  echo "##vso[task.setvariable variable=vnetCreated;isOutput=true]$VNET_NAME"
else
  echo "Virtual Network '$VNET_NAME' already exists."
fi
