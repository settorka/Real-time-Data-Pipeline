package com.example.springbootservice;

import com.mongodb.client.MongoCollection;
import org.bson.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Service;

@Service
public class KafkaConsumer {

    @Autowired
    private MongoCollection<Document> mongoCollection;

    @KafkaListener(topics = "springboot", groupId = "springboot-group")
    public void listen(String message) {
        Document record = Document.parse(message);
        mongoCollection.insertOne(record);
        System.out.println("Record inserted into MongoDB: " + record.toJson());
    }
}
