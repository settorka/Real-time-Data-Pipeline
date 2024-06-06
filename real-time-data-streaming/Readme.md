## Project Overview

Post multiple records to a database from multiple sources

## Requirements
Database should be able to handle multiple sub-second writes from multiple sources (Available and consistent)

Sources are APIs making post requests to the DB

Data is being fed from a random data generator

Data record consists of
- API name
- Random text (10 characters)
- Current time

## Capacity planning
Microservice design  
- can handle downtime of any given API
- asynchronous message passing 

Data will be coming fast to the mul-> high throughput
- Pipeline/robust message broker/queue to handle this

CAP theorem for DB -> MongoDB
- less verbose and complex implementation and async handling
- sharding and replication better than Cassandra

## Tools
- Desired APIs -> Dockerized Microservices:
-- Node.js with Express
-- Ruby on Rails
-- ASP.NET Core
-- Spring Boot
-- Django 
-- Elixir Phoenix

- Data Generator: Go -> best for concurrent and parallel data generation -> Dockerized microservice

- Message Broker: Kafka ->  -> Zookeeper + Kafka dockerized 

- Database: MongoDB 

- Frontend: React with WebSocket (using Socket.IO) -> Real time updates when data fails/succeeds in DB posting

Connection: Websockets -> direct passing of data to db

