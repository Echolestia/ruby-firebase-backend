#!/bin/bash
# 🛑 Ensure the script stops on first error 🛑
set -e

# Check if a process is listening on port 8080, and if so, kill it
if sudo lsof -t -i:8080 > /dev/null
then
    echo -e "\e[31m🚀 Killing process on port 8080...\e[0m"
    sudo kill $(sudo lsof -t -i:8080)
fi

# 🧹 Function to clean up background processes on exit 🧹
cleanup() {
    echo -e "\e[33m🔴 Stopping Cloud SQL Proxy...\e[0m"
    kill -s SIGTERM $CLOUD_SQL_PROXY_PID
    exit 0
}

# 🪝 Trap INT (Ctrl+C) signal to clean up background processes 🪝
trap cleanup INT

# 🚀 Start Cloud SQL Proxy 🚀
echo -e "\e[32m🌐 Starting Cloud SQL Proxy...\e[0m"
./cloud-sql-proxy echolestia:asia-southeast1:rubybackend -c service_account.json  -p 8080 &
CLOUD_SQL_PROXY_PID=$!

# ⏳ Give the proxy a moment to establish connection ⏳
sleep 2

# 🚦 Run the migrations 🚦
echo -e "\e[34m🔁 Running migrations...\e[0m"
bin/rails db:migrate RAILS_ENV=development

# 🎉 Start the Rails server 🎉
echo -e "\e[35m🚀 Starting Rails server...\e[0m"
rails server -p 3000
