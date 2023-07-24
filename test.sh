#!/bin/bash

# Define some colors to use
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

for file in spec/controllers/*.rb
do
  echo -e "${GREEN}Running $file...${NC}"
  RAILS_ENV=test bundle exec rspec --format documentation $file
  echo -e "${BLUE}Waiting for 10 seconds before running the next test...${NC}"
  sleep 10  # wait for 10 seconds before running the next test
done

echo -e "${GREEN}All tests completed.${GREEN}"
