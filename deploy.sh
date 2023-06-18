#!/bin/bash

# make sure the script stops if there is any error
set -e

echo -e "\n\033[1;33mBuilding the Docker image...\033[0m"
docker build -t gcr.io/rubyintro/myapp . --no-cache && echo -e "\n\033[1;32mDocker image built successfully!\033[0m"

echo -e "\n\033[1;33mAuthenticating Docker to gcloud...\033[0m"
gcloud auth configure-docker && echo -e "\n\033[1;32mDocker authenticated to gcloud successfully!\033[0m"

echo -e "\n\033[1;33mPushing the Docker image to gcloud...\033[0m"
docker push gcr.io/rubyintro/myapp && echo -e "\n\033[1;32mDocker image pushed successfully!\033[0m"

echo -e "\n\033[1;33mDeploying the Docker image to Cloud Run...\033[0m"
gcloud run deploy --image gcr.io/rubyintro/myapp --platform managed && echo -e "\n\033[1;32mDocker image deployed to Cloud Run successfully!\033[0m"
