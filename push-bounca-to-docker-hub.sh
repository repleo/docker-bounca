#!/bin/bash -e

if [ -z ${1} ]; 
then 
 echo "Please provide the version tag as first argument. For example: ./push-bounca-to-docker-hub.sh v0.1.0";
 exit 1
fi 

docker build -t "repleo/bounca:$1" -t "repleo/bounca:latest" .
docker push repleo/bounca:$1
docker push repleo/bounca:latest

