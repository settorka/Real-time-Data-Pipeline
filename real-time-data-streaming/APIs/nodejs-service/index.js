const kafka = require('./kafkaConsumer');
const express = require('express');
const app = express();
const port = 5000;

app.listen(port, () => {
  console.log(`Node.js service listening at http://localhost:${port}`);
  kafka.consumeMessages();
});
