defmodule PhoenixService.KafkaHandler do
  use KafkaEx.GenConsumer
  require Logger

  defmodule State do
    defstruct mongo_client: nil, mongo_db: nil, mongo_collection: nil
  end

  @impl true
  def init(_consumer_group, _topic, _partition) do
    mongo_url = System.get_env("MONGO_URI") || "mongodb://mongo:27017"
    mongo_client = Mongo.start_link(url: mongo_url)
    mongo_db = "mydatabase"
    mongo_collection = "generatedRecords"
    {:ok, %State{mongo_client: mongo_client, mongo_db: mongo_db, mongo_collection: mongo_collection}}
  end

  @impl true
  def handle_message_set(messages, state) do
    Enum.each(messages, fn %KafkaEx.Protocol.Fetch.Message{value: value} ->
      Logger.info("Received message: #{value}")

      case Jason.decode(value) do
        {:ok, record} ->
          Mongo.insert_one(state.mongo_client, "#{state.mongo_db}.#{state.mongo_collection}", record)
          Logger.info("Record inserted into MongoDB: #{inspect(record)}")
        {:error, reason} ->
          Logger.error("Failed to decode message: #{reason}")
      end
    end)

    {:async_commit, state}
  end
end
