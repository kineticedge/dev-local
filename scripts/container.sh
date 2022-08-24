#!/bin/bash

#
# This local environment was designed for a 64GB machine, but should work fine with 32GB. 
#
# However, to run with fewer resources, certain services might be best to not be enabled.
#
#

DIR=$(dirname $0)/..

DOCKER_COMPOSE=${DIR}/kafka/docker-compose.yml


usage() {
  echo ""
  echo "Usage: $0 {--uncomment|--comment|--toggle} {broker-4|connect-2|connect-3|ksql-server-2}"
  echo ""
}


if [[ $# -eq 0 ]]; then
  usage
  exit
fi

COMMENT=toggle

for i in "$@"; do
  case $i in
    --uncomment) 
      COMMAND=uncomment
      ;;
    --comment) 
      COMMAND=comment
      ;;
    --toggle) 
      COMMAND=toggle
      ;;
    broker-4)
      DOCKER_COMPOSE=${DIR}/kafka/docker-compose.yml
      start=$(grep -n  "^#\?  broker-4:" ${DOCKER_COMPOSE} | cut -d: -f1)
      end=$(expr $(grep -n  "^#\?  schema-registry:" ${DOCKER_COMPOSE} | cut -d: -f1) - 2)
      ;;
    connect-2)
      DOCKER_COMPOSE=${DIR}/connect/docker-compose.yml
      start=$(grep -n  "^#\?  connect-2:" ${DOCKER_COMPOSE} | cut -d: -f1)
      end=$(expr $(grep -n  "^#\?  connect-3:" ${DOCKER_COMPOSE} | cut -d: -f1) - 2)
      ;;
    connect-3)
      DOCKER_COMPOSE=${DIR}/connect/docker-compose.yml
      start=$(grep -n  "^#\?  connect-3:" ${DOCKER_COMPOSE} | cut -d: -f1)
      end="$"
      ;;
    ksql-server-2)
      DOCKER_COMPOSE=${DIR}/ksqldb/docker-compose.yml
      start=$(grep -n  "^#\?  ksql-server-2:" ${DOCKER_COMPOSE} | cut -d: -f1)
      end="$"
      ;;
    *)
      usage
      ;;
  esac
  shift
done



IS_COMMENTED=$(sed -n "${start}p" ${DOCKER_COMPOSE} | cut -c1)

if [[ "${IS_COMMENTED}" == "#" ]] && [[ "${COMMAND}" == "comment" ]]; then 
  echo ""
  echo "already commented out"
  echo ""
  exit
elif [[ "${IS_COMMENTED}" == " " ]] && [[ "${COMMAND}" == "uncomment" ]]; then 
  echo ""
  echo "already uncommented"
  echo ""
  exit
fi



if [ "${IS_COMMENTED}" == "#" ]; then 
  echo "uncommenting"
  sed -I "" -E -e "${start},${end}s/^#(.*)$/\1/" ${DOCKER_COMPOSE}
else
  echo "commenting out"
  sed -I "" -E -e "${start},${end}s/^(.*)$/#\1/" ${DOCKER_COMPOSE}
fi

