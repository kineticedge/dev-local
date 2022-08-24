#!/bin/bash

cd $(dirname $0)/..

#if [ ! -f ./prometheus-emitter-0.22.0.jar ]; then
# curl -s -O https://repo1.maven.org/maven2/org/apache/druid/extensions/contrib/prometheus-emitter/0.22.0/prometheus-emitter-0.22.0.jar
#fi

druid-protobuf-extension


docker run -it --rm --entrypoint '' -v $(pwd)/druid/extensions:/opt/druid/extensions -v "druid_shared:/opt/shared" "apache/druid:0.22.0" sh -c "java -cp \"lib/*\" -Ddruid.extensions.directory=\"extensions\" -Ddruid.extensions.hadoopDependenciesDir=\"hadoop-dependencies\" org.apache.druid.cli.Main tools pull-deps --no-default-hadoop -c \"org.apache.druid.extensions.contrib:druid-protobuf-extension:0.22.0\""


