defmodule PhoenixService.MixProject do
  use Mix.Project

  def project do
    [
      app: :phoenix_service,
      version: "0.1.0",
      elixir: "~> 1.14",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  def application do
    [
      mod: {PhoenixService.Application, []},
      extra_applications: [:logger, :runtime_tools, :kafka_ex, :mongodb_driver, :connection]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:phoenix, "~> 1.6.0"},
      {:phoenix_pubsub, "~> 2.0"},
      {:phoenix_live_view, "~> 0.17.5"},
      {:phoenix_html, "~> 3.0"},
      {:phoenix_live_dashboard, "~> 0.6.0"},
      {:telemetry_metrics, "~> 0.6"},
      {:telemetry_poller, "~> 1.0"},
      {:gettext, "~> 0.11"},
      {:jason, "~> 1.0"},
      {:plug_cowboy, "~> 2.0"},
      {:swoosh, "~> 1.5"},
      {:kafka_ex, "~> 0.10.0"},
      {:mongodb_driver, "~> 0.7.0"},
      {:connection, "~> 1.0.4"},
      {:kaffe, "~> 1.17"},
      {:finch, "~> 0.8"}
    ]
  end

  defp aliases do
    [
      setup: ["deps.get"]
    ]
  end
end
