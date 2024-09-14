# Real-time data pipeline

Cloud-Native application for sink-source stream processing of JSON records
- Data Generator using Golang to concurrently generate JSON record. Can specify records/sec.
  - Rate can updated via HTTP POST request,
  - generator can be stopped/started via HTTP POST request.

- Kafka Pipeline to consume records upstream and sink them downstream to API consumers via message topics.
  
- REST APIs as Kafka Consumers which receive Kafka topics and post them to MongoDB
  - Python Flask
  - Ruby on Rails
  - Java Springboot
  - Elixir Phoenix
  - Express + Node.js
    
- MongoDB replicas to handle influx of post requests to DB,
  - deployed locally for test
  -   Was hosted on Azure Kubernetes Engine using
    - Terraform
    - Helm (bitnami for mongodb) + Kubernetes
    - https://learn.microsoft.com/en-us/azure/aks/mongodb-overview
