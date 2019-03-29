defmodule Islands.Board.Cache.MixProject do
  use Mix.Project

  def project do
    [
      app: :islands_board_cache,
      version: "0.1.2",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      name: "Islands Board Cache",
      source_url: source_url(),
      description: description(),
      package: package(),
      deps: deps()
    ]
  end

  defp source_url do
    "https://github.com/RaymondLoranger/islands_board_cache"
  end

  defp description do
    """
    Board Cache for the Game of Islands. Returns a random board.
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "assets", "config/persist*.exs"],
      maintainers: ["Raymond Loranger"],
      licenses: ["MIT"],
      links: %{"GitHub" => source_url()}
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Islands.Board.Cache.App, :ok}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:mix_tasks,
       github: "RaymondLoranger/mix_tasks", only: :dev, runtime: false},
      {:log_reset, "~> 0.1"},
      {:file_only_logger, "~> 0.1"},
      {:persist_config, "~> 0.1"},
      {:islands_coord, "~> 0.1"},
      {:islands_island, "~> 0.1"},
      {:islands_board, "~> 0.1"},
      {:logger_file_backend, "~> 0.0.9"},
      {:earmark, "~> 1.0", only: :dev},
      {:ex_doc, "~> 0.14", only: :dev, runtime: false},
      {:dialyxir, "~> 0.5", only: :dev, runtime: false}
    ]
  end
end
