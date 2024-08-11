#!/bin/bash

set -e
cd "$(dirname -- "$0")"

cd ..

(cd monitoring; docker compose down -v)
(cd dashboards; docker compose down -v)
(cd ksqlDB; docker compose down -v)
(cd connect; docker compose down -v)
(cd ksqlDB; docker compose down -v)
(cd kafka; docker compose down -v)
(cd kafka-raft; docker compose down -v)
(cd mongo; docker compose down -v)
(cd mysql; docker compose down -v)
(cd mysql5; docker compose down -v)
(cd postgres; docker compose down -v)
(cd storage; docker compose down -v)
(cd flink; docker compose down -v)
(cd elasticsearch; docker compose down -v)
(cd druid; docker compose down -v)
(cd pinot; docker compose down -v)
(cd cassandra; docker compose down -v)
