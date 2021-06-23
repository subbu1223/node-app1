#!/bin/bash

# This is to demo

node_app1=`docker ps -a | grep nodeapp1 | awk '{print $NF}'`
if [ $node_app1=='nodeapp1' ]; then
    echo "nodeapp is running, lets delete"
        docker rm -f nodeapp
fi

images=`docker images | grep devopsb5/nodejenkins | awk '{print $3}'`
docker rmi $images
docker run -d -p 8080:8080 --name nodeapp1 $1
