# Introduction

* This project is to provide a complete ecosystem to do local Kafka development w/out the need to connect to external systems.

* Each directory has its own `docker-compose.yml` and its own docker-compose project defined in the `.env` property file.

  * this makes it easy to start/stop only what you need.
  
  * the network is created as external to allow for the containers between compose files to communicate while also not
    requiring any specific docker compose to be running.
  
* Even though you are running all of the Kafka components from docker containers, you will want the software installed 
  locally so you can use the command line operations; personally, I install the confluent community edition installation
  locally in `/usr/local/confluent`, and add `/usr/local/confluent/bin` to my path.
  
* Go to Confluent's [get-started](https://www.confluent.io/get-started), select the **here** link (javascript so I cannot deep link it) 
  in the Download Confluent Platform section to get the download for community edition.

  * On A Mac M1 Laptop, Java 17 or later is needed. The `KSQL_JVM_PERFORMANCE_OPTS` as deprecated settings, if you run into issues

  * `/usr/local/confluent/ksql-run-class`
  
    replace
   
    ```shell
    KSQL_JVM_PERFORMANCE_OPTS="-server -XX:+UseConcMarkSweepGC -XX:+CMSClassUnloadingEnabled -XX:+CMSScavengeBeforeRemark -XX:+ExplicitGCInvokesConcurrent -XX:NewRatio=1 -Djava.awt.headless=true"
    ```
    
    with

     ```shell
    KSQL_JVM_PERFORMANCE_OPTS="-server -XX:+ExplicitGCInvokesConcurrent -XX:NewRatio=1 -Djava.awt.headless=true"
    ```
  
* Projects are being added to allow for a rich set of applications to be used in a local environment.
Some are still incubating, some are well tested.

# kafka

  * This is the `Apache Kafka Cluster` and is the core pieces needed for working with Kafka Brokers
  
  * 1 Zookeeper
  
  * 4 Brokers
  
  * 1 Schema Registry
  
  * If you are running on a machine with limited resources, considering commenting out `broker-4`.
  
  * Having 4 brokers showcases how Kafka works better, in that most topics have a replication factor of 3,
  and this showcases that some brokers do not have any data for a given partition of a topic.
  
  * Only one zookeeper is provided, in an actual setup we would have 3 or 5 zookeepers. As of Kafka 2.8 it is possible
    to explore Kafka w/out the use of Zookeeper for the quorum.
  
  * Only one schema registry is provided, in an actual setup we would have 2 for high-availability reasons.

# connect

  * As of Kafka 2.6 (`confluent-community` 6.0) most of the bundled connectors were removed; this is great in that it allows
  for easier upgrading of connectors w/out having to upgrade `connect`.

  * Place the desired connectors (unzipped) into the ./jars directory.

# monitoring

  * this is an optional set of containers to monitor the health of Kafka
  
  * Grafana provides a dashboard to monitoring the Kafka metrics.
  
    * `http://localhost:3000`
    
    * username: `admin`
    
    * password: `grafana`
  
  * `kowl` and `kafka-ui` are provided for kafka exploration through a UI interface. I have not used `kafka-ui`, but
     looks promising. I enjoy using `kowl`. Other options to use would be `akhq`, `kafdrop` and `conduktor`.
  
 
# ksqlDB

 * a single KSQL Server
 
 * to access the command line interface have confluent community installed locally, or uncomment out the client
images and use the following:
 
   ```
   docker exec -it kl_ksql-client bash
   % ksql http://ksql-server:8088
   ```

# kafka-lb

  * ability to add a load-balancer in front of each broker. 

  * scripts to add network latency to each broker to test various scenarios 

  * see the "LB" advetised listener in the kafka docker-compose file for the port used for such setup

# elasticsearch

  * provides elasticsearch and kabana containers

# postgres

  * provides a postgres database, with the write-ahead log (wal) enabled for change-data-capture from Debezium.

  * see Debezium connector in connectors for accessing data with CDC.

  * Standard port is exposed `5432` for easy integration into developers tools.

# mysql

 * provides a MySQL v8 database, bin-log enabled by default with v8.
  
 * see Debezium connector in connectors for accessing data with CDC.

  * Standard port is exposed `3306` for easy integration into developers tools.

# mysql5

  * provides a MySQL v5 database with bin-log enabled

  * see Debezium connector in connectors for accessing data with CDC.

  * Internal `3306` port exposed as `3307` to avoid conflics with `mysql` instance.

# mongo

  * Mongo with a single replica set created, to allow for Debezium to properly use it with change-data-capture.

  * The `secret.key` can be used as-is, or you can replace it with a new secret key using the `secret.sh` set.

  * The secret.key is required to allow for authentication and replica sets, since in a multi-node deployment, each
  replica would need the same secret key.

# cassandra

  * An Apache Cassandra v4 instance.

# druid

  * A complete setup for running Druid. 
  Druid image is amd64, so running the provided image is rather slow. The `.env` is stood up for allowing different images, and building your own arm64 image is rather easy, details to come.

  * Details (and referenced project) for building arm64 based images [druid-m1](https://www.kineticedge.io/blog/druid-m1/).

  * All druid ports are exposed with prefixing with a `4`, such as coordinator's `8081` is `48081`.

# pinot

  * this is a rather new container setup, but I have used to for a POC.

# storage

  * Minio is a s3 compliant object store. Great for testing s3 connectors locally.

# flink

  * 1 Job Manager

    * Please uber-jars in `./jars` to make the accessible to the job manager for scheduling.
 
    * Use `./data` folder for any output - easier to use for development and validation.

  * 2 Task Managers, easily scaled with `deploy.replicas`.

# oracle

  * provides an Oracle datbase with logminer enabled
 
  * see kafka-connect-logminer in connectors for accessing data with CDC.
 
  * the Oracle container must be built, see [README](./oracle/README.md).


