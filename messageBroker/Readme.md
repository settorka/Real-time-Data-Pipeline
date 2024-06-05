# Kafka Topic Setup

This guide provides instructions for verifying and creating Kafka topics using Docker.

## Prerequisites

- Docker and Docker Compose are installed on your machine.
- Kafka and Zookeeper services are running using Docker Compose.

## Verifying and Creating Topics

### Using Docker Exec to Enter Kafka Container

1. Enter the Kafka container:
    ```sh
    docker exec -it kafka /bin/bash
    ```

### Create Topics Using Kafka CLI

2. Create the topics inside the Kafka container:
    ```sh
    # Create the `nodejs` topic
    kafka-topics --create --topic nodejs --bootstrap-server localhost:9092 --partitions 1 --replication-factor 1

    # Create the `rails` topic
    kafka-topics --create --topic rails --bootstrap-server localhost:9092 --partitions 1 --replication-factor 1

    # Create the `phoenix` topic
    kafka-topics --create --topic phoenix --bootstrap-server localhost:9092 --partitions 1 --replication-factor 1

    # Create the `django` topic
    kafka-topics --create --topic django --bootstrap-server localhost:9092 --partitions 1 --replication-factor 1

    # Create the `springboot` topic
    kafka-topics --create --topic springboot --bootstrap-server localhost:9092 --partitions 1 --replication-factor 1

    # Create the `aspnetcore` topic
    kafka-topics --create --topic aspnetcore --bootstrap-server localhost:9092 --partitions 1 --replication-factor 1
    ```

### Verify Topics

3. List all topics to verify creation:
    ```sh
    kafka-topics --list --bootstrap-server localhost:9092
    ```

By following these steps, you will have successfully created and verified the Kafka topics required for your project.
