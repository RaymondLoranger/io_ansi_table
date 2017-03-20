defmodule IO.ANSI.Table.Mixfile do
  use Mix.Project

  def project do
    [
      app: :io_ansi_table,
      version: "0.1.0",
      elixir: "~> 1.4",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      name: "IO ANSI Table",
      source_url: "https://github.com/RaymondLoranger/io_ansi_table",
      description: description(),
      package: package(),
      aliases: aliases(),
      deps: deps()
    ]
  end

  defp description do
    """
    Prints data to STDOUT in a table with borders and colors.
    Can choose a table style among the 16 already predefined.
    """
  end

  def package do
    [
      maintainers: ["Raymond Loranger"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/RaymondLoranger/io_ansi_table"
      }
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:earmark, "~> 1.0", only: :dev},
      {:ex_doc, "~> 0.14", only: :dev, runtime: false},
      {:dialyxir, "~> 0.4", only: :dev, runtime: false}
    ]
  end

  defp aliases do
    [docs: ["docs", &copy_images/1]]
  end

  defp copy_images(_) do
    File.cp_r "images", "doc/images", fn src, dst ->
      IO.gets(~s|Overwriting "#{dst}" with "#{src}". Proceed? [Yn]\s|)
      in ["y\n", "Y\n"]
    end
  end
end
