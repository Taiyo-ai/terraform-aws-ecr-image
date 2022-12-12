#!/bin/bash

# Inspiration from https://github.com/onnimonni/terraform-ecr-docker-build-module

# Fail fast
set -e

# This is the order of arguments
build_folder=$1
aws_ecr_repository_url_with_tag=$2
src_copy_dir=$3
domain_name=$4
owner_account=$5
region=$6

# Check that aws is installed
which aws > /dev/null || { echo 'ERROR: aws-cli is not installed' ; exit 1; }

# Connect into aws
$(aws ecr get-login --no-include-email) || { echo 'ERROR: aws ecr login failed' ; exit 1; }

# Check that docker is installed and running
which docker > /dev/null && docker ps > /dev/null || { echo 'ERROR: docker is not running' ; exit 1; }

# Code Artifact login
export codeartifact_auth_token=$(aws codeartifact get-authorization-token --domain $domain_name --domain-owner $owner_account --region $region --query authorizationToken --output text) || { echo 'ERROR: aws code artifact login failed' ; exit 1; }

# Some Useful Debug
echo "Building $aws_ecr_repository_url_with_tag from $build_folder/Dockerfile"

# Build image
docker build -t $aws_ecr_repository_url_with_tag $build_folder \
 --build-arg SRC_COPY_DIR=$src_copy_dir \
 --build-arg CODEARTIFACT_AUTH_TOKEN=$codeartifact_auth_token \
 --build-arg DOMAIN_NAME=$domain_name \
 --build-arg OWNER_ACCOUNT=$owner_account \
 --build-arg REGION=$region

# Push image
docker push $aws_ecr_repository_url_with_tag