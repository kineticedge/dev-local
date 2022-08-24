#!/bin/sh

#
# jmxterm is a command line utility for accessing JMX Metrics; it is a great way to explore metrics of a Java application launched 
# within a container.
#

cd $(dirname $0)/..

if [ ! -f ./kafka/jmx_prometheus/jmxterm.jar ]; then

  echo ""
  echo "downloading jmxterm.jar"
  echo ""
  curl -s -L -o ./kafka/jmx_prometheus/jmxterm.jar  https://github.com/jiaqi/jmxterm/releases/download/v1.0.2/jmxterm-1.0.2-uber.jar

else
  
  echo ""
  echo "jmxterm.jar already downloaded"
  echo ""

fi
