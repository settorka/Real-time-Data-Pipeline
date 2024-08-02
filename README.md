# Real-time data pipeline

Sink-source implementation for stream processing of JSON records
- Data Generator written in Go to concurrently generate JSON records at a specified rate/s. Rate can updated via HTTP POST request, generator can be stopped/started too.
- Kafka Pipeline to consume upstream records and sink them downstream to API consumers via message topics.
- APIs in Python Flask, Ruby on Rails, Elixir Phoenix, Express + Node.js which receive Kafka topics and post them to MongoDB
- MongoDB replicas to handle influx of post requests to DB, hosted on cluster
