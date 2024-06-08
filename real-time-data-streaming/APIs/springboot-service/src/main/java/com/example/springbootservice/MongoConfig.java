package com.example.springbootservice;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class MongoConfig {

    @Bean
    public MongoClient mongoClient() {
        return MongoClients.create(System.getenv("MONGO_URI"));
    }

    @Bean
    public MongoDatabase mongoDatabase(MongoClient mongoClient) {
        return mongoClient.getDatabase("mydatabase");
    }

    @Bean
    public MongoCollection<Document> mongoCollection(MongoDatabase mongoDatabase) {
        return mongoDatabase.getCollection("generatedRecords");
    }
}
