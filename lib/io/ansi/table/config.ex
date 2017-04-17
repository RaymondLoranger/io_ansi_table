
defmodule IO.ANSI.Table.Config do
  @moduledoc """
  Defines functions to retrieve table config properties at **runtime**.
  """

  Mix.Project.config[:config_path] |> Mix.Config.read! |> Mix.Config.persist
  @external_resource Path.expand Mix.Project.config[:config_path]
  @app               Mix.Project.config[:app]
  @default_margins   Application.get_env(@app, :default_margins)
  @max_width_range   Application.get_env(@app, :max_width_range)
  @upper_max_width   @max_width_range.last

  @doc """
  Retrieves the headers of a table.

  ## Examples

      iex> alias IO.ANSI.Table.Config
      iex> Config.headers
      [:unknown]
  """
  @spec headers :: [any]
  def headers do
    Application.get_env(@app, :headers, [:unknown])
  end

  @doc """
  Retrieves the key headers of a table.

  ## Examples

      iex> alias IO.ANSI.Table.Config
      iex> Config.key_headers
      []
  """
  @spec key_headers :: [any]
  def key_headers do
    Application.get_env(@app, :key_headers, [])
  end

  @doc """
  Retrieves the maximum column width of a table.

  ## Examples

      iex> alias IO.ANSI.Table.Config
      iex> Config.max_width
      99
  """
  @spec max_width :: non_neg_integer
  def max_width do
    Application.get_env(@app, :max_width, @upper_max_width)
  end

  @doc """
  Retrieves the header fixes for a table.

  ## Examples

      iex> alias IO.ANSI.Table.Config
      iex> Config.header_fixes
      %{}
  """
  @spec header_fixes :: map
  def header_fixes do
    Application.get_env(@app, :header_fixes, %{})
  end

  @doc """
  Retrieves the margins to leave around a table.

  ## Examples

      iex> alias IO.ANSI.Table.Config
      iex> Config.margins(nil)
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
