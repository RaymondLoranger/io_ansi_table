defmodule IO.ANSI.Table.Mixfile do
  use Mix.Project

  def project do
    [
      app: :io_ansi_table,
      version: "1.0.34",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      name: "IO ANSI Table",
      source_url: source_url(),
      description: description(),
      package: package(),
      # aliases: aliases(),
      deps: deps()
    ]
  end

  defp source_url do
    "https://github.com/RaymondLoranger/io_ansi_table"
  end

  defp description do
    """
    Writes data to "stdio" in a table with borders and colors.
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
      mod: {IO.ANSI.Table.TopSup, :ok}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:dialyxir, "~> 1.0", only: :dev, runtime: false},
      {:ex_doc, "~> 0.22", only: :dev, runtime: false},
      {:file_only_logger, "~> 0.2"},
      # {:file_only_logger, path: "../file_only_logger"},
      {:io_ansi_plus, "~> 0.1"},
      {:log_reset, "~> 0.1"},
      # {:log_reset, path: "../log_reset"},
      {:map_sorter, "~> 0.2"},
      # {:map_sorter, path: "../map_sorter"},
      {:persist_config, "~> 0.4", runtime: false}
    ]
  end

  # defp aliases do
  #   [
  #     # docs: ["docs", &copy_images/1]
  #     docs: ["docs", &echo_xcopy/1, ~S"cmd xcopy images docs\images /Y"]
  #   ]
  # end

  # defp echo_xcopy(_) do
  #   IO.ANSI.Plus.puts([:light_yellow, "xcopy images docs\images /Y"])
  # end

  # defp copy_images(_) do
  #   File.cp_r("images", "doc/images",
  #     on_conflict: fn src, dst ->
  #       IO.gets(~s|Overwriting "#{dst}" with "#{src}".\nProceed? [Yn]\s|) in [
  #         "y\n",
  #         "Y\n"
  #       ]
  #     end
  #   )
  # end
end
