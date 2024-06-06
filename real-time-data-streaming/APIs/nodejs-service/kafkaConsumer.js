const kafka = require('kafka-node');
const { MongoClient } = require('mongodb');

const mongoUrl = 'mongodb://mongo:27017';
const dbName = 'mydatabase';
const collectionName = 'generatedRecords';

async function consumeMessages() {
  const client = new kafka.KafkaClient({ kafkaHost: 'kafka:9092' });
  const consumer = new kafka.Consumer(
    client,
    [{ topic: 'nodejs', partition: 0 }],
    { autoCommit: true }
  );

  const mongoClient = new MongoClient(mongoUrl, { useNewUrlParser: true, useUnifiedTopology: true });

  try {
    await mongoClient.connect();
    console.log("Connected to MongoDB");

    const db = mongoClient.db(dbName);
    const collection = db.collection(collectionName);

    consumer.on('message', async function (message) {
      const record = JSON.parse(message.value);
      await collection.insertOne(record);
      console.log("Record inserted into MongoDB", record);
    });
  } catch (err) {
    console.error(err);
  }
}

module.exports = { consumeMessages };
