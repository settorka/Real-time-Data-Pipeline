import Config

# Enables the Phoenix server if the environment variable PHX_SERVER is set
if System.get_env("PHX_SERVER") do
  config :phoenix_service, PhoenixServiceWeb.Endpoint, server: true
end

# Configuration specific to the production environment
if config_env() == :prod do
  # Fetch the secret key base from the environment variable or raise an error if not set
  secret_key_base =
    System.get_env("SECRET_KEY_BASE") ||
      raise """
      environment variable SECRET_KEY_BASE is missing.
      You can generate one by calling: mix phx.gen.secret
      """

  # Set the host and port for the Phoenix endpoint
  host = System.get_env("PHX_HOST") || "example.com"
  port = String.to_integer(System.get_env("PORT") || "4000")

  # Configure the Phoenix endpoint with the host, port, and secret key base
  config :phoenix_service, PhoenixServiceWeb.Endpoint,
    url: [host: host, port: 443, scheme: "https"],
    http: [
      # Enable IPv6 and bind on all interfaces
      ip: {0, 0, 0, 0, 0, 0, 0, 0},
      port: port
    ],
    secret_key_base: secret_key_base

  # Configure MongoDB connection
  config :mongodb_driver, url: "mongodb://mongo:27017/mydatabase"

  # Configure Swoosh to use Finch
  config :swoosh, :api_client, Swoosh.ApiClient.Finch

  # Configure Kaffe for production
  config :kaffe,
    consumer: [
      endpoints: [kafka: 9092],
      topics: ["phoenix"],
      consumer_group: "phoenix-group",
      message_handler: PhoenixService.KafkaHandler
    ]
end

# Configuration for non-production environments
if config_env() != :prod do
  # Configure MongoDB connection
  config :mongodb_driver, url: "mongodb://localhost:27017/mydatabase"

  # Configure Swoosh to use Finch
  config :swoosh, :api_client, Swoosh.ApiClient.Finch

  # Configure Kaffe for non-production
  config :kaffe,
    consumer: [
      endpoints: [localhost: 9092],
      topics: ["phoenix"],
      consumer_group: "phoenix-group",
      message_handler: PhoenixService.KafkaHandler
    ]
end
