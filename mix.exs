defmodule IO.ANSI.Table.Mixfile do
  use Mix.Project

  def project do
    [
      app: :io_ansi_table,
      version: "0.4.18",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      name: "IO ANSI Table",
      source_url: source_url(),
      description: description(),
      package: package(),
      aliases: aliases(),
      deps: deps()
    ]
  end

  defp source_url do
    "https://github.com/RaymondLoranger/io_ansi_table"
  end

  defp description do
    """
    Prints data to STDOUT in a table with borders and colors.
    Can choose a table style to change the look of the table.
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
      mod: {IO.ANSI.Table.App, :ok}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:mix_tasks,
       github: "RaymondLoranger/mix_tasks", only: :dev, runtime: false},
      {:persist_config, "~> 0.1"},
      {:io_ansi_plus, "~> 0.1"},
      {:map_sorter, "~> 0.2"},
      {:earmark, "~> 1.0", only: :dev},
      {:ex_doc, "~> 0.14", only: :dev, runtime: false},
      {:dialyxir, "~> 0.5", only: :dev, runtime: false}
    ]
  end

  defp aliases do
    [
      docs: ["docs", &copy_images/1]
    ]
  end

  defp copy_images(_) do
    File.cp_r("images", "doc/images", fn src, dst ->
      # Always true...
      src || dst

      # IO.gets(~s|Overwriting "#{dst}" with "#{src}".\nProceed? [Yn]\s|) in [
      #   "y\n",
      #   "Y\n"
      # ]
    end)
  end
end
