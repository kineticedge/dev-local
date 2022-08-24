#!/bin/bash

# 
# only works on running containers, since volume size is based on executing the du command on all volumes from within the container
#

containers=$(docker ps --format '{{.Names}}|{{.ID}}' | sort)

for container in $containers; do

  id=$(echo $container | cut -d\| -f2)
  name=$(echo $container | cut -d\| -f1)
  volumes=$(docker inspect -f '{{range .Mounts}}{{ if eq .Type "volume" }}{{.Destination}} {{end}}{{end}}' $id)

  echo $name

  if [ "$volumes" != "" ]; then
    docker exec $id du -d 0 -h $volumes
  fi

  echo ""

done


