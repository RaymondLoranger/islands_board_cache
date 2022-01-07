defmodule Islands.Board.Cache.MixProject do
  use Mix.Project

  def project do
    [
      app: :islands_board_cache,
      version: "0.1.22",
      elixir: "~> 1.11",
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
      files: ["lib", "mix.exs", "README*", "config/persist*.exs"],
      maintainers: ["Raymond Loranger"],
      licenses: ["MIT"],
      links: %{"GitHub" => source_url()}
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Islands.Board.Cache.TopSup, :ok}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:dialyxir, "~> 1.0", only: :dev, runtime: false},
      {:ex_doc, "~> 0.22", only: :dev, runtime: false},
      {:file_only_logger, "~> 0.1"},
      {:islands_board, "~> 0.1"},
      {:islands_coord, "~> 0.1"},
      {:islands_island, "~> 0.1"},
      {:log_reset, "~> 0.1"},
      {:persist_config, "~> 0.4", runtime: false}
    ]
  end
end
