## Overview

Multi-API approach to DB record posting. 
Use 4 APIs make posts to one MongoDB. 

## Requirements
Database should be able to handle multiple sub-second writes from multiple sources (Available and consistent)

Data passed is the API where the data is from, the message (random text) and the current time. 

On the interface, 
- Stop the posting service
- Start the posting service
- log the history of posts in real-time or near real-time
- control the data generator service which makes the post such that
-- post randomly to any of the m apis, m=4
-- post to n apis specifically in an ordered fashion, 1<=n<=3
-- stop posting , m=n = 0
-- change the rate of posts per second for any APIs

Metrics on the posting will be built as another service, which will be linked to this Control  page.


## Design


## Tools
- APIs:
-- Node.js with Express
-- Ruby on Rails
-- ASP.NET Core
-- Spring Boot
-- Django 
-- Elixir Phoenix

- Data Generator: Go -> best for concurrent and parallel data generation
- Message Broker: Kafka -> handle high throughput of incoming messages from multiple APIs
- Database: MongoDB -> CA, sharding and replication better than Cassandra
- Frontend: React with WebSocket (using Socket.IO) -> Real time updates when data fails/succeeds in DB posting

