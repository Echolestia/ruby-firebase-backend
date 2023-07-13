#!/bin/bash

# 🛑 make sure the script stops if there is any error 🛑
set -e

# 🪝 Set a trap to handle Ctrl+C 🪝
trap 'kill $(jobs -p); exit' SIGINT

start_time=$SECONDS
total_estimated_time=130

# Open fd 3 for stdout
exec 3>&1

{
  echo -e "\n\033[1;33m🔄 Updating Swagger for Rails...\033[0m" >&3
  bundle exec rake rswag:specs:swaggerize && echo -e "\n\033[1;32m✅ Swagger for Rails updated successfully!\033[0m" >&3

  echo -e "\n\033[1;33m🔨 Building the Docker image...\033[0m" >&3
  docker build -t gcr.io/echolestia/rubybackend . --no-cache && echo -e "\n\033[1;32m✅ Docker image built successfully!\033[0m" >&3

  echo -e "\n\033[1;33m🔑 Authenticating Docker to gcloud...\033[0m" >&3
  gcloud auth configure-docker && echo -e "\n\033[1;32m✅ Docker authenticated to gcloud successfully!\033[0m" >&3

  echo -e "\n\033[1;33m⏫ Pushing the Docker image to gcloud...\033[0m" >&3
  docker push gcr.io/echolestia/rubybackend && echo -e "\n\033[1;32m✅ Docker image pushed successfully!\033[0m" >&3

  echo -e "\n\033[1;33m🚀 Deploying the Docker image to Cloud Run...\033[0m" >&3
  gcloud run deploy rubybackend --image gcr.io/echolestia/rubybackend --set-env-vars "RAILS_ENV=production" --platform managed --region asia-southeast1 --allow-unauthenticated && echo -e "\n\033[1;32m✅ Docker image deployed to Cloud Run successfully!\033[0m" >&3
} &

while kill -0 $! >/dev/null 2>&1; do
  elapsed=$((SECONDS - start_time))
  percentage=$((elapsed * 100 / total_estimated_time))
  progress=$((percentage / 2))
  printf "⏱ Elapsed time: %d seconds [%-50s] %d%%🔋\r" $elapsed $(printf '%.0s#' $(seq 1 $progress)) $percentage
  sleep 1
done

elapsed=$((SECONDS - start_time))
percentage=$((elapsed * 100 / total_estimated_time))
progress=$((percentage / 2))
printf "⏱ Elapsed time: %d seconds [%-50s] %d%%🔋\n" $elapsed $(printf '%.0s#' $(seq 1 $progress)) $percentage
