defmodule PhoenixService.KafkaHandler do
  @behaviour Kaffe.Consumer

  require Logger

  @impl true
  def handle_messages(messages) do
    for %{value: value} = message <- messages do
      Logger.info("Received message: #{value}")
      save_to_mongodb(value)
    end
    :ok
  end

  defp save_to_mongodb(value) do
    case Mongo.start_link(url: "mongodb://mongo:27017/mydatabase") do
      {:ok, conn} ->
        record = Jason.decode!(value)
        case Mongo.insert_one(conn, "generatedRecords", record) do
          {:ok, _result} ->
            Logger.info("Successfully inserted record into MongoDB")
          {:error, reason} ->
            Logger.error("Failed to insert record into MongoDB: #{inspect(reason)}")
        end
      {:error, reason} ->
        Logger.error("Failed to connect to MongoDB: #{inspect(reason)}")
    end
  end
end
