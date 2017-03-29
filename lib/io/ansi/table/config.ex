
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
      iex> Config.headers
      []
  """
  def headers do
    Application.get_env(@app, :headers, [])
  end

  @doc """
  Retrieves the key headers of a table.

  ## Examples

      iex> alias IO.ANSI.Table.Config
      iex> Config.key_headers
      []
  """
  def key_headers do
    Application.get_env(@app, :key_headers, [])
  end

  @doc """
  Retrieves the header terms of a table.

  ## Examples

      iex> alias IO.ANSI.Table.Config
      iex> Config.header_terms
      []
  """
  def header_terms do
    Application.get_env(@app, :header_terms, [])
  end

  @doc """
  Retrieves the margins to leave around a table.

  ## Examples

      iex> alias IO.ANSI.Table.Config
      iex> Config.margins([])
      [top: 1, bottom: 1, left: 2]
  """
  @spec margins(Keyword.t | nil) :: Keyword.t
  def margins(nil) do
    margins Application.get_env(@app, :margins, [])
  end
  def margins(margins) do
    Keyword.merge(@default_margins, margins)
  end
end
