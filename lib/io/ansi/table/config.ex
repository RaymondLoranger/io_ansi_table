
defmodule IO.ANSI.Table.Config do
  @moduledoc """
  Defines functions to retrieve table config properties at **runtime**.
  """

  Mix.Project.config[:config_path] |> Mix.Config.read! |> Mix.Config.persist
  @external_resource Path.expand Mix.Project.config[:config_path]
  @app               Mix.Project.config[:app]
  @default_margins   Application.get_env(@app, :default_margins)

  @doc """
  Retrieves the headers of a table.

  ## Examples

      iex> alias IO.ANSI.Table.Config
      iex> # config :io_ansi_table, headers: ["number", "created_at"]
      iex> # Config.headers # => ["number", "created_at"]
      iex> Config.headers
      []
  """
  def headers do
    Application.get_env(@app, :headers, [])
  end

  @doc """
  Retrieves the key header of a table.

  ## Examples

      iex> alias IO.ANSI.Table.Config
      iex> # config :io_ansi_table, key_header: "created_at"
      iex> # Config.key_header # => "created_at"
      iex> Config.key_header
      nil
  """
  def key_header do
    Application.get_env(@app, :key_header)
  end

  @doc ~S"""
  Retrieves the top margin to leave above a table.

  ## Examples

      iex> alias IO.ANSI.Table.Config
      iex> # config :io_ansi_table, margins: [top: 4]
      iex> # Config.margin_top # => "\n\n\n\n"
      iex> Config.margin_top
      ""
  """
  @spec margin_top :: String.t
  def margin_top do
    margins = Application.get_env(@app, :margins, [])
    String.duplicate "\n", Keyword.merge(@default_margins, margins)[:top]
  end

  @doc ~S"""
  Retrieves the bottom margin to leave under a table.

  ## Examples

      iex> alias IO.ANSI.Table.Config
      iex> # config :io_ansi_table, margins: [bottom: 3]
      iex> # Config.margin_bottom # => "\n\n\n"
      iex> Config.margin_bottom
      ""
  """
  @spec margin_bottom :: String.t
  def margin_bottom do
    margins = Application.get_env(@app, :margins, [])
    String.duplicate "\n", Keyword.merge(@default_margins, margins)[:bottom]
  end

  @doc ~S"""
  Retrieves the left margin to leave left of a table.

  ## Examples

      iex> alias IO.ANSI.Table.Config
      iex> # config :io_ansi_table, margins: [left: 2]
      iex> # Config.margin_left # => "\s\s"
      iex> Config.margin_left
      ""
  """
  @spec margin_left :: String.t
  def margin_left do
    margins = Application.get_env(@app, :margins, [])
    String.duplicate "\s", Keyword.merge(@default_margins, margins)[:left]
  end
end
