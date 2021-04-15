# CI/CD Pipeline for Machine Learning Project in Azure
Deploying a Flask Machine Learning Application on Azure App Services.

### Status

[![Python application test with Github Actions](https://github.com/marcoBrighterAI/flask-ml-azure-serverless/actions/workflows/main.yml/badge.svg?branch=main)](https://github.com/marcoBrighterAI/flask-ml-azure-serverless/actions/workflows/main.yml)

### Introduction
This project builds a **Continuous Integration** pipeline using **GitHub Actions**, and a **Continuous Delivery** pipeline
using **Azure Pipelines** for a Machine Learning Application. The app is implemented in python using scikit-learn and the
flask module. **Azure App Services** is used to host the application. In this repo you will find all the code and configurations
necessary to implement CI/CD. The ML application is simple, however, it can be easily extended.


### Dependencies
- [Azure Account](https://portal.azure.com) 
- [Azure command line interface](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest) (Only if running locally)

### Project Plan
To follow DevOps best practices, in the links bellow you will find a Kanban Trello board, and a spreadsheet
showing the project plan, deliverables and goals.

* Trello board
* Project plan spreadsheet

### Getting Started

1. Fork this repository
2. Log into the [Azure Portal](https://portal.azure.com) 
3. Launch Azure Cloud Shell 

### Instructions
To run this project in the Azure Cloud Shell, follow the steps bellow. The same steps apply when running locally, however,
you would need to log into your Azure Account from the terminal first.

1. Clone the forked repo in Azure Cloud Shell
2. Create virtual environment and source
3. Deploy your app in Azure Cloud Shell
5. Verify Machine Learning predictions works
6. Verify Continuous Integration by changing app.py
7. Create a Webapp in Azure App Services
8. Create an Azure DevOps Project and connect to Azure
9. Create a Python Pipeline with GitHub Integration
10. Verify Continuous Delivery by changing app.py


#### 1. Clone the forked repo in Azure Cloud Shell
``` bash 
    git clone git@github.com:marcoBrighterAI/flask-ml-azure-serverless.git
    cd flask-ml-azure-serverless/
    ls
```
![pycharm1](git-clone-output.png)

Note:  You make need to follow this YouTube video guide on how to [setup SSH keys and configure Azure Cloud Shell with Github](https://www.youtube.com/watch?v=3vtBAfPjQus).

#### 2. Create virtual environment and source
``` bash 
    make setup
    source ~/.flask-ml-azure-serverless/bin/activate
```
#### 3. Deploy your app in Azure Cloud 
To start the app run the following commands:
``` bash 
    make all
    python app.py
```
![pycharm2](make-all-output.png)

After running both commands you should see an output like the screenshot bellow.

![pycharm3](python-app-output.png)

Now you can open the *Web preview* by clicking in the icon depicted with the red dot in the image above and set the port to `5000`.
A new window will open, and you should see you web app running. See image bellow.
![pycharm4](web-app-running.png)

#### 5. Verify Machine Learning predictions works
First open a new Azure Cloud Shell then run the commands bellow.
``` bash 
    cd flask-ml-azure-serverless/
    ./make_predict.sh
```
The model should predict the output depicted bellow.

![pycharm5](prediction-output.png)

#### 6. Verify Continuous Integration by changing app.py
To verify that the Continuous Integration is working you can open the editor in Azure Cloud Shell and change the welcome
message in the app.py script (line 25). Then commit and push your changes. 

![pycharm6](change-welcome-message.png)

Now you can you open your GitHub repo and go to the *Actions* section. You will see that a new pipeline has been triggered.
The pipeline will test your changes and make sure that the code is in a deployable state. See image bellow.

![pycharm7](github-actions.png)

#### 7. Create a Webapp in Azure App Services
7.1. Create a Resource Group
``` bash
    az group create --name "RESOURCE_GROUP_NAME" --location "LOCATION" --tags udacity=udacity-project2
```
7.2. Set the default resource group and region for subsequent commands
``` bash
    az configure --defaults group="RESOURCE_GROUP_NAME" location="LOCATION"
```
7.3. Run the following command to create and deploy the App Service app. Replace <your_app_name> 
with a unique name that becomes the URL, http://<your_app_name>.azurewebsites.net.
``` bash
    az webapp up --name <your_app_name> --logs --launch-browser
```
For additional information of how to create an App service click on the links bellow:
- [Create App Service with Azure CLI](https://docs.microsoft.com/en-us/azure/developer/javascript/tutorial/tutorial-vscode-azure-cli-node/tutorial-vscode-azure-cli-node-03) 
- [Create App Service from the Azure Portal](https://medium.com/@nasreddine.skandrani/deploy-from-visual-studio-code-to-azure-bb5a25059339)

#### 8. Create an Azure DevOps Project and connect to Azure
Since the documentation for the Azure Console and Azure Pipelines is subject to change, it is recommended to follow the
official documentation on how to [Create an Azure DevOps project and connect to Azure](https://docs.microsoft.com/en-us/azure/devops/pipelines/ecosystems/python-webapp?view=azure-devops#create-an-azure-devops-project-and-connect-to-azure)
However, you can also watch this Walkthrough video of this process.

#### 9. Create a Python Pipeline with GitHub Integration
***Important:*** This project contains an azure-pipelines.yml already configure, therefore, we will rename it and use it as reference
to configure the new pipeline.
``` bash
    mv azure-pipelines.yml azure-pipelines-old.yml
```
Here is the link to the official documentation on how to [Create a Python-specific pipeline to deploy to App Service](https://docs.microsoft.com/en-us/azure/devops/pipelines/ecosystems/python-webapp?view=azure-devops#create-a-python-specific-pipeline-to-deploy-to-app-service).
You can also watch this Walkthrough video of this process.

For more information on the content of the YAML file you can follow this link: [YAML pipeline explained](https://docs.microsoft.com/en-us/azure/devops/pipelines/ecosystems/python-webapp?view=azure-devops#yaml-pipeline-explained)

#### 10. Verify Continuous Delivery by changing app.py


<TODO:  
* Architectural Diagram (Shows how key parts of the system work)>

<TODO:  Instructions for running the Python project.  How could a user with no context run this project without asking you for any help.  Include screenshots with explicit steps to create that work. Be sure to at least include the following screenshots:

* Project running on Azure App Service

* Project cloned into Azure Cloud Shell

* Passing tests that are displayed after running the `make all` command from the `Makefile`

* Output of a test run

* Successful deploy of the project in Azure Pipelines.  [Note the official documentation should be referred to and double checked as you setup CI/CD](https://docs.microsoft.com/en-us/azure/devops/pipelines/ecosystems/python-webapp?view=azure-devops).

* Running Azure App Service from Azure Pipelines automatic deployment

* Successful prediction from deployed flask app in Azure Cloud Shell.  [Use this file as a template for the deployed prediction](https://github.com/udacity/nd082-Azure-Cloud-DevOps-Starter-Code/blob/master/C2-AgileDevelopmentwithAzure/project/starter_files/flask-sklearn/make_predict_azure_app.sh).
The output should look similar to this:

```bash
udacity@Azure:~$ ./make_predict_azure_app.sh
Port: 443
{"prediction":[20.35373177134412]}
```

* Output of streamed log files from deployed application

> 

## Enhancements

<TODO: A short description of how to improve the project in the future>

## Demo 

<TODO: Add link Screencast on YouTube>


