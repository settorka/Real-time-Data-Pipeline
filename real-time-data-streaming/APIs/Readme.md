# APIs 


## List of APIs to Implement
- Node.js with Express
- Ruby on Rails
- ASP.NET Core
- Spring Boot
- Django
- Elixir Phoenix

### Each API will:

- Consume messages from its respective Kafka topic.
- Post the messages to the MongoDB collection "generatedRecords".

## Common Steps for All APIs
Set Up Kafka Consumer: Each service will have a Kafka consumer to read messages from its respective topic.
MongoDB Integration: Each service will post the consumed messages to MongoDB.
Dockerize the Services: Each service will be containerized using Docker for easy deployment.

## Deployment 
'''bash
$ cd APIs
$ sudo docker-compose -f docker-compose.apis.yml up --build --d
$ sudo docker-compose -f docker-compose.apis.yml down
'''
