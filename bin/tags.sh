#!/bin/bash

while getopts a:r:s:f:t: flag
do
    case "${flag}" in
        a) aws_region=${OPTARG};;
        r) repo=${OPTARG};;
        s) service=${OPTARG};;
        f) from=${OPTARG};;
        t) to=${OPTARG};;
    esac
done

# Allow overriding the aws region from system
if [ "$aws_region" != "" ]; then
  aws_extra_flags="--region $aws_region"
else
  aws_extra_flags=""
fi

# Check that aws is installed
which aws > /dev/null || { echo 'ERROR: aws-cli is not installed' ; exit 1; }

# Check that docker is installed and running
which docker > /dev/null && docker ps > /dev/null || { echo 'ERROR: docker is not running' ; exit 1; }

# Connect into aws
aws ecr get-login-password $aws_extra_flags | docker login --username AWS --password-stdin $repo/$service:$from

echo "Updating $service with $from version and pushing as $to"
IFS=','
read -ra arr <<< "$to"
docker pull $repo/$service:$from
for tag in "${arr[@]}";
do
  echo "Updating $service with $from version and pushing as $to"
  docker tag $repo/$service:$from $repo/$service:$tag
  docker push  $repo/$service:$tag
done

echo "tags updated!"
