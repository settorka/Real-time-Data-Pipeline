db = db.getSiblingDB('mydatabase');

db.createCollection('generatedRecords');

db.generatedRecords.insertMany([
  { apiName: "nodejs", randomText: "abcdefghij", currentTime: new Date() },
  { apiName: "rails", randomText: "klmnopqrst", currentTime: new Date() }
]);
