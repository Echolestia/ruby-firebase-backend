# Start from the official ruby image
FROM ruby:3.0.0

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Set the work directory
WORKDIR /myapp

# Copy Gemfile and Gemfile.lock into the image
# We do this before copying the full application to take advantage of Docker's caching mechanism
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock

# Install gems
RUN bundle install

# Copy the application into the container
COPY . /myapp

# Download and install Cloud SQL Proxy
RUN wget https://dl.google.com/cloudsql/cloud_sql_proxy.linux.amd64 -O cloud_sql_proxy
RUN chmod +x cloud_sql_proxy

# Set environment variables
ENV DB_SOCKET_DIR=/cloudsql
ENV INSTANCE_CONNECTION_NAME=echolestia:asia-southeast1:rubybackend
ENV PORT=8080
ENV RAILS_ENV=production


# Copy the service account key into the Docker image
COPY /service_account.json /service_account.json

# Start Cloud SQL Proxy, run migrations and start the Rails server
CMD ./cloud_sql_proxy -dir=${DB_SOCKET_DIR} -instances=${INSTANCE_CONNECTION_NAME} -credential_file=/service_account.json & \
    bundle exec rails db:migrate && bundle exec rails db:seed && \
    bundle exec rails s -p $PORT -b '0.0.0.0'
