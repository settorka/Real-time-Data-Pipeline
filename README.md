# Real-time data pipeline

Cloud-Native application for sink-source stream processing of JSON records
- Data Generator using Golang to concurrently generate JSON records at a specified rate/s.
  - Rate can updated via HTTP POST request,
  - generator can be stopped/started via HTTP POST request.

- Kafka Pipeline to consume upstream records and sink them downstream to API consumers via message topics.
  
- REST APIs as which receive Kafka topics and post them to MongoDB
  - Python Flask
  - Ruby on Rails
  - Java Springboot
  - Elixir Phoenix
  - Express + Node.js
    
- MongoDB replicas to handle influx of post requests to DB, hosted on Azure Kubernetes Engine using
  - Terraform
  - Helm (bitnami for mongodb) + Kubernetes
