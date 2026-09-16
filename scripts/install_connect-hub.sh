#!/bin/bash

cd $(dirname $0)

CWD=$(pwd)

mkdir -p ./tmp

if [ ! -f ./tmp/confluent-hub-client.tar.gz ]; then
  echo "downloading..."
  curl -s -o ./tmp/confluent-hub-client.tar.gz  http://client.hub.confluent.io/confluent-hub-client-latest.tar.gz
fi

(cd /usr/local/confluent; gzcat ${CWD}/tmp/confluent-hub-client.tar.gz | tar xfv -)
