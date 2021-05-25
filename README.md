# CI/CD Pipeline for Machine Learning Project in Azure
Deploying a Flask Machine Learning Application on Azure App Services.

### Status

[![Python application test with Github Actions](https://github.com/marcoBrighterAI/flask-ml-azure-serverless/actions/workflows/main.yml/badge.svg?branch=main)](https://github.com/marcoBrighterAI/flask-ml-azure-serverless/actions/workflows/main.yml)

[![Build Status](https://dev.azure.com/marcopaspuel/Flask-ML-Deploy/_apis/build/status/marcoBrighterAI.flask-ml-azure-serverless?branchName=main)](https://dev.azure.com/marcopaspuel/Flask-ML-Deploy/_build/latest?definitionId=1&branchName=main)

### Introduction
This project builds a **Continuous Integration** pipeline using **GitHub Actions**, and a **Continuous Delivery** pipeline
using **Azure Pipelines** for a Machine Learning Application. The app is implemented in python using scikit-learn and the
flask module. **Azure App Services** is used to host the application. In this repo you will find all the code and configurations
necessary to implement CI/CD. The ML application is simple, however, it can be easily extended.

![pycharm1](images/project-architecture.png)

### Dependencies
- [Azure Account](https://portal.azure.com) 
- [Azure command line interface](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest) (Only if running locally)
- [Azure DevOps Account](https://dev.azure.com/) 

### Project Plan
To follow DevOps best practices, in the links bellow you will find a Kanban Trello board, and a spreadsheet
showing the project plan, project deliverables and project goals.

* [Trello board](https://trello.com/b/boMOaYDS/ci-cd-pipeline-for-machine-learning-project-in-azure)
* [Project plan spreadsheet](https://docs.google.com/spreadsheets/d/1YuwbRiXFODAtWOqejUCbbSH1ag5XcuXN_TyVgkzjHNE/edit?usp=sharing)

### Getting Started

1. Fork this repository
2. Log into the [Azure Portal](https://portal.azure.com) 
3. Launch Azure Cloud Shell 

### Instructions
To run this project in the Azure Cloud Shell, follow the steps bellow. The same steps apply when running locally, however,
you would need to log into your Azure Account from the terminal first.

- [1. Clone the forked repo in Azure Cloud Shell](#1-clone-the-forked-repo-in-azure-cloud-shell)
- [2. Create virtual environment and source](#2-create-virtual-environment-and-source)
- [3. Deploy your app in Azure Cloud](#3-deploy-your-app-in-azure-cloud)
- [4. Verify Machine Learning predictions works](#4-verify-machine-learning-predictions-works)
- [5. Verify Continuous Integration by changing app.py](#5-verify-continuous-integration-by-changing-apppy)
- [6. Create a Webapp in Azure App Services](#6-create-a-webapp-in-azure-app-services)
- [7. Create an Azure DevOps Project and connect to Azure](#7-create-an-azure-devops-project-and-connect-to-azure)
- [8. Create a Python Pipeline with GitHub Integration](#8-create-a-python-pipeline-with-github-integration)
- [9. Verify Continuous Delivery by changing app.py](#9-verify-continuous-delivery-by-changing-apppy)
- [10. Verify Machine Learning Prediction in Azure Apps](#10-verify-machine-learning-prediction-in-azure-apps)
- [11. Load test the application using Locust](#11-load-test-the-application-using-locust)


#### 1. Clone the forked repo in Azure Cloud Shell
``` bash 
    git clone git@github.com:marcoBrighterAI/flask-ml-azure-serverless.git
    cd flask-ml-azure-serverless/
    ls
```
![pycharm1](images/git-clone-output.png)

Note:  You may need to follow this YouTube video guide on how to [setup SSH keys and configure Azure Cloud Shell with Github](https://www.youtube.com/watch?v=3vtBAfPjQus).

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
![pycharm2](images/make-all-output.png)

After running both commands you should see an output like the screenshot bellow.

![pycharm3](images/python-app-output.png)

Now you can open the *Web preview* by clicking in the icon depicted with the red dot in the image above and set the port to `5000`.
A new window will open, and you should see you web app running. See image bellow.
![pycharm4](images/web-app-running.png)

#### 4. Verify Machine Learning predictions works
First open a new Azure Cloud Shell then run the commands bellow.
``` bash 
    cd flask-ml-azure-serverless/
    ./make_predict.sh
```
The model should predict the output depicted bellow.

![pycharm5](images/prediction-output.png)

#### 5. Verify Continuous Integration by changing app.py
To verify that the Continuous Integration is working you can open the editor in Azure Cloud Shell and change the welcome
message in the [app.py](app.py) script (line 25). Then commit and push your changes. 

![pycharm6](images/change-welcome-message.png)

Now you can you open your GitHub repo and go to the *Actions* section. You will see that a new pipeline has been triggered.
The pipeline will test your changes and make sure that the code is in a deployable state. See image bellow.

![pycharm7](images/github-actions.png)

#### 6. Create a Webapp in Azure App Services
##### 6.1. Create a Resource Group
``` bash
    az group create --name "RESOURCE_GROUP_NAME" --location "LOCATION" --tags udacity=udacity-project2
```
##### 6.2. Set the default resource group and region for subsequent commands
``` bash
    az configure --defaults group="RESOURCE_GROUP_NAME" location="LOCATION"
```
##### 6.3. Run the following command to create and deploy the App Service app. Replace <your_app_name> 
with a unique name that becomes the URL, http://<your_app_name>.azurewebsites.net.
``` bash
    az webapp up --name <your_app_name> --logs --launch-browser
```
Alternately, you can run the [commands.sh](commands.sh) script, it will a resource group and then create and deploy the
App service. Make sure to change the names accordingly!

For additional information of how to create an App service click on the links bellow:
- [Create App Service with Azure CLI](https://docs.microsoft.com/en-us/azure/developer/javascript/tutorial/tutorial-vscode-azure-cli-node/tutorial-vscode-azure-cli-node-03) 
- [Create App Service from the Azure Portal](https://medium.com/@nasreddine.skandrani/deploy-from-visual-studio-code-to-azure-bb5a25059339)

#### 7. Create an Azure DevOps Project and connect to Azure
The screenshots below show the steps, but if you need to, you can also refer to [the official documentation for more detail](https://docs.microsoft.com/en-us/azure/devops/pipelines/ecosystems/python-webapp?view=azure-devops#create-an-azure-devops-project-and-connect-to-azure).

##### 7.1. In a browser, go to [dev.azure.com](https://dev.azure.com/).
Once you sign in, the browser will display your Azure DevOps dashboard.

##### 7.2. Create a new project and name it

![pycharm8](images/8-1-create-new-project.png)

##### 7.3 Set up a new service connection via Azure Resource Manager and Pipeline

![pycharm9](images/8-3-new-service-connection.png)

![pycharm10](images/8-3-2-new-service-connection.png)

#### 8. Create a Python Pipeline with GitHub Integration
***Important:*** This project contains an [azure-pipelines.yml](.devops/pipelines/azure-pipelines.yml) already configure, therefore, we will rename it and use it as reference
to configure the new pipeline.

##### 8.1. To rename the YAML file run the command bellow in the project's root directory.
``` bash
    mv azure-pipelines.yml azure-pipelines-old.yml
```

##### 8.2. Select Pipelines, create a new one and add GitHub Integration

![pycharm11](images/8-4-pipeline-integration.png)

##### 8.3. Configure Python to Linux Web App Azure

![pycharm12](images/8-5-configure-python-app.png)

This process will create a new YAML file that looks roughly like the azure-pipelines.yml provided with this project.

##### 8.4. Modify the azure-pipelines.yml file based on the file provided with this project. 

If you need to, you can also refer to [the official documentation](https://docs.microsoft.com/en-us/azure/devops/pipelines/ecosystems/python-webapp?view=azure-devops#create-a-python-specific-pipeline-to-deploy-to-app-service),
and to the official [Azure Pipeline YAML documentation](https://docs.microsoft.com/en-us/azure/devops/pipelines/ecosystems/python-webapp?view=azure-devops#yaml-pipeline-explained) 
for more information about it.

#### 9. Verify Continuous Delivery by changing app.py
To verify that the Continuous Delivery is working you can open the editor in Azure Cloud Shell and change the welcome
message again in the [app.py](app.py) script (line 25).

Note: You will need to pull the changes first before committing and pushing. See image bellow.

![pycharm13](images/10-1-change-welcome-message.png)

After pushing the changes you can go back to [dev.azure.com](https://dev.azure.com/). Select your project, and then select
*Pipelines*. You will see that a new deployment has been triggered. 

![pycharm14](images/10-2-trigger-new-pipeline.png)

Once the deployment is done you can open the URL http://<your_app_name>.azurewebsites.net to see the changes. 

![pycharm15](images/10-3-website-screenshot.png)

#### 10. Verify Machine Learning Prediction in Azure Apps
Now we can use this URL to run predictions. To do so, you can open the make_predict_azure_app.sh bash script and replace 
line 28 to match your app URL. Then run the following command.
``` bash 
    ./make_predict_azure_app.sh
```
See image bellow and verity you get the same output.

![pycharm16](images/10-4-model-output.png)

You can stream the logs from your running application with the following command.
``` bash 
    az webapp log tail --name <your_app_name> -g "RESOURCE_GROUP_NAME"
```

![pycharm17](images/10-5-output-logs.png)


#### 11. Load test the application using Locust
Open a new terminal and navigate to the project's root directory. Then run the following commands to activate the 
environment and start locus.
``` bash 
    source ~/.flask-ml-azure-serverless/bin/activate
    locust --web-port 8091
```
Then open a *Web preview* and set the port to `8091`. Fill in the parameters and click start swarming. See images bellow.

![pycharm18](images/11-1-locust-set-up.png)

![pycharm19](images/11-2-locust-output.png)

### Enhancements

- Containerize the webapp in a docker image and publish the docker image to the Azure Container Registry.
- Deploy a Kubernetes version of the project on Azure Kubernetes Service (AKS) for high scalability and cost efficiency.
- Deploy a more complex Machine Learning Application. E.g. Image Recognition.

### Demo 

- [Screencast on YouTube](https://www.youtube.com/watch?v=aIvl4NxCWwU)

### Helpful resources from Microsoft
These are all excellent official documentation examples from Microsoft that explain key components of Python-based
Continuous Delivery on Azure:

- [Azure Quickstart](https://docs.microsoft.com/en-us/azure/app-service/quickstart-python?tabs=bash&WT.mc_id=udacity_learn-wwl&pivots=python-framework-flask)
- [Use CI/CD to deploy a Python web app to Azure App Service on Linux](https://docs.microsoft.com/en-us/azure/devops/pipelines/ecosystems/python-webapp?view=azure-devops&WT.mc_id=udacity_learn-wwl)
- [Create a CI/CD pipeline for Python with Azure DevOps Starter](https://docs.microsoft.com/en-us/azure/devops-project/azure-devops-project-python?WT.mc_id=udacity_learn-wwl)
- [Continuous deployment to Azure App Service](https://docs.microsoft.com/en-us/azure/app-service/deploy-continuous-deployment?tabs=github#option-1-use-app-service-kudu-build-server?WT.mc_id=udacity_learn-wwl)
- [Flask on Azure App Services](https://docs.microsoft.com/en-us/azure/app-service/quickstart-python?tabs=bash&WT.mc_id=udacity_learn-wwl&pivots=python-framework-flask)
- [Azure Pipelines for Python](https://docs.microsoft.com/en-us/azure/devops/pipelines/ecosystems/python?view=azure-devops&WT.mc_id=udacity_learn-wwl)
