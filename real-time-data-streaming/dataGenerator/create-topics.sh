#!/bin/bash

create_topic() {
  topic_name=$1
  if [[ $(kafka-topics --bootstrap-server localhost:9092 --list | grep -w $topic_name) ]]; then
    echo "Topic $topic_name already exists."
  else
    kafka-topics --create --topic $topic_name --bootstrap-server localhost:9092 --partitions 1 --replication-factor 1
    echo "Topic $topic_name created."
  fi
}

topics=("nodejs" "rails" "phoenix" "django" "springboot" "aspnetcore")

for topic in "${topics[@]}"
do
  create_topic $topic
done
