defmodule IO.ANSI.Table.Config do
  # @moduledoc """
  # Gets table properties.
  # """
  @moduledoc false

  use PersistConfig

  alias IO.ANSI.Table.{Column, Style}

  @default_align_specs Application.get_env(@app, :default_align_specs)
  @default_bell Application.get_env(@app, :default_bell)
  @default_count Application.get_env(@app, :default_count)
  @default_headers Application.get_env(@app, :default_headers)
  @default_header_fixes Application.get_env(@app, :default_header_fixes)
  @default_margins Application.get_env(@app, :default_margins)
  @default_sort_specs Application.get_env(@app, :default_sort_specs)
  @default_sort_symbols Application.get_env(@app, :default_sort_symbols)
  @default_style Application.get_env(@app, :default_style)
  @max_width_range Application.get_env(@app, :max_width_range)
  @lower_max_width @max_width_range.first
  @upper_max_width @max_width_range.last

  @spec align_specs() :: [Column.align_spec]
  def align_specs() do
    @app
    |> Application.get_env(:align_specs, @default_align_specs)
    |> align_specs()
  end

  @spec align_specs(any) :: [Column.align_spec]
  def align_specs(any) when is_list(any), do: any
  def align_specs(_), do: @default_align_specs

  @spec bell() :: boolean
  def bell() do
    @app
    |> Application.get_env(:bell, @default_bell)
    |> bell()
  end

  @spec bell(any) :: boolean
  def bell(any) when is_boolean(any), do: any
  def bell(_), do: @default_bell

  @spec count() :: integer
  def count() do
    @app
    |> Application.get_env(:count, @default_count)
    |> count()
  end

  @spec count(any) :: integer
  def count(any) when is_integer(any), do: any
  def count(_), do: @default_count

  @spec headers() :: [any]
  def headers() do
    @app
    |> Application.get_env(:headers, @default_headers)
    |> headers()
  end

  @spec headers(any) :: [any]
  def headers(any) when is_list(any), do: any
  def headers(_), do: @default_headers

  @spec header_fixes() :: map
  def header_fixes() do
    @app
    |> Application.get_env(:header_fixes, @default_header_fixes)
    |> header_fixes()
  end

  @spec header_fixes(any) :: map
  def header_fixes(any) when is_map(any), do: any
  def header_fixes(_), do: @default_header_fixes

  @spec margins() :: Keyword.t
  def margins() do
    @app
    |> Application.get_env(:margins, @default_margins)
    |> margins()
  end

  @spec margins(any) :: Keyword.t
  def margins(any) when is_list(any) do
    if Keyword.keyword?(any), do: any, else: @default_margins
  end
  def margins(_), do: @default_margins

  @spec max_width() :: Column.width
  def max_width() do
    @app
    |> Application.get_env(:max_width, @upper_max_width)
    |> max_width()
  end

  @spec max_width(any) :: Column.width
  def max_width(any) when is_integer(any) do
    cond do
      any < @lower_max_width -> @lower_max_width
      any > @upper_max_width -> @upper_max_width
      true -> any
    end
  end
  def max_width(_), do: @upper_max_width

  @spec sort_specs() :: [Column.sort_spec]
  def sort_specs() do
    @app
    |> Application.get_env(:sort_specs, @default_sort_specs)
    |> sort_specs()
  end

  @spec sort_specs(any) :: [Column.sort_spec]
  def sort_specs(any) when is_list(any), do: any
  def sort_specs(_), do: @default_sort_specs

  @spec sort_symbols() :: Keyword.t
  def sort_symbols() do
    @app
    |> Application.get_env(:sort_symbols, @default_sort_symbols)
    |> sort_symbols()
  end

  @spec sort_symbols(any) :: Keyword.t
  def sort_symbols(any) when is_list(any) do
    if Keyword.keyword?(any), do: any, else: @default_sort_symbols
  end
  def sort_symbols(_), do: @default_sort_symbols

  @spec style() :: Style.t
  def style() do
    @app
    |> Application.get_env(:style, @default_style)
    |> style()
  end

  @spec style(any) :: Style.t
  def style(any) when is_atom(any) do
    if Enum.member?(Style.styles(), any), do: any, else: @default_style
  end
  def style(_), do: @default_style
end
