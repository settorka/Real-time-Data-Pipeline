import Config

config :phoenix_service,
  generators: [timestamp_type: :utc_datetime]

config :phoenix_service, PhoenixServiceWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [json: PhoenixServiceWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: PhoenixService.PubSub,
  live_view: [signing_salt: "xMSsmK2w"]

config :phoenix_service, PhoenixService.Mailer, adapter: Swoosh.Adapters.Local

config :esbuild,
  version: "0.17.11",
  phoenix_service: [
    args: ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

config :tailwind,
  version: "3.4.0",
  phoenix_service: [
    args: ~w(--config=tailwind.config.js --input=css/app.css --output=../priv/static/assets/app.css),
    cd: Path.expand("../assets", __DIR__)
  ]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

config :kafka_ex,
  brokers: [{"kafka", 9092}],
  consumer_group: "phoenix-group"

config :kaffe,
  consumer: [
    endpoints: [kafka: 9092],
    topics: ["phoenix"],
    consumer_group: "phoenix-group",
    message_handler: PhoenixService.KafkaHandler,
    offset_reset_policy: :reset_to_latest,
    max_bytes: 500_000,
    worker_allocation_strategy: :worker_per_topic_partition
  ]



config :mongodb_driver, url: "mongodb://mongo:27017/mydatabase"

config :swoosh, :api_client, Swoosh.ApiClient.Finch

import_config "#{config_env()}.exs"
