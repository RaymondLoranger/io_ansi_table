
defmodule IO.ANSI.Table.Config do
  @moduledoc """
  Defines functions to retrieve table config properties.
  """

  Mix.Project.config[:config_path] |> Mix.Config.read! |> Mix.Config.persist
  @app             Mix.Project.config[:app]
  @ansi_enabled    Application.get_env(@app, :ansi_enabled)
  @default_margins Application.get_env(@app, :default_margins)
  @line_types      Application.get_env(@app, :line_types)

  @doc """
  Checks if ANSI coloring is enabled.

  ## Examples

      iex> alias IO.ANSI.Table.Config
      iex> Config.ansi_enabled?
      true
  """
  @spec ansi_enabled? :: boolean
  def ansi_enabled? do
    @ansi_enabled
  end

  @doc """
  Retrieves the line types of a table.

  ## Examples

      iex> alias IO.ANSI.Table.Config
      iex> Config.line_types
      [:top, :header, :separator, :data, :bottom]
  """
  @spec line_types :: [atom]
  def line_types do
    @line_types
  end

  @doc ~S"""
  Retrieves the top margin above a table.

  ## Examples

      iex> alias IO.ANSI.Table.Config
      iex> Config.margin_top(top: 4)
      "\n\n\n\n"
  """
  @spec margin_top(Keyword.t) :: String.t
  def margin_top(margins) do
    String.duplicate "\n", Keyword.merge(@default_margins, margins)[:top]
  end

  @doc ~S"""
  Retrieves the bottom margin under a table.

  ## Examples

      iex> alias IO.ANSI.Table.Config
      iex> Config.margin_bottom(bottom: 3)
      "\n\n\n"
  """
  @spec margin_bottom(Keyword.t) :: String.t
  def margin_bottom(margins) do
    String.duplicate "\n", Keyword.merge(@default_margins, margins)[:bottom]
  end

  @doc """
  Retrieves the left margin on the left-hand side of a table.

  ## Examples

      iex> alias IO.ANSI.Table.Config
      iex> Config.margin_left(left: 2)
      "\s\s"
  """
  @spec margin_left(Keyword.t) :: String.t
  def margin_left(margins) do
    String.duplicate "\s", Keyword.merge(@default_margins, margins)[:left]
  end
end
