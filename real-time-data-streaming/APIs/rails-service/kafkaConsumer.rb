require 'ruby-kafka'
require 'mongo'

mongo_client = Mongo::Client.new(['mongo:27017'], database: 'mydatabase')
collection = mongo_client[:generatedRecords]

kafka = Kafka.new(seed_brokers: ["kafka:9092"], client_id: "rails-service")

consumer = kafka.consumer(group_id: "rails-group")
consumer.subscribe("rails")

trap("TERM") { consumer.stop }

consumer.each_message do |message|
  record = JSON.parse(message.value)
  collection.insert_one(record)
  puts "Record inserted into MongoDB: #{record}"
end
