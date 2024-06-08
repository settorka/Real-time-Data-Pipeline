use Mix.Config

config :kaffe,
  consumer: [
    endpoints: [kafka: 9092],
    topics: ["phoenix"],
    consumer_group: "phoenix-group",
    message_handler: PhoenixService.KafkaHandler
  ]
