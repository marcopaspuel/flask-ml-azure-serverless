#!/usr/bin/env bash

# Create a Resource Group
az group create --name udacity-project-2-rg --location westeurope --tags udacity=udacity-project2

# Create and deploy the App Service app
az webapp up --sku F1 --name flask-ml-service-marco -g udacity-project-2-rg
