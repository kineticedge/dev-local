#!/bin/sh

if [ "${DRUID}" == "" ]; then
  echo "environment variable DRUID is not defined."
  exit
fi

echo "Druid URL ${DRUID}"

turnilo --druid ${DRUID}

