defmodule IO.ANSI.Table.Spec do
  @moduledoc """
  Holds the specification of the table to be formatted.
  """

  use PersistConfig

  alias IO.ANSI.Table.{Column, Config, Heading, Row}

  @type t :: map

  @default_header_fixes Application.get_env(@app, :default_header_fixes)
  @default_margins Application.get_env(@app, :default_margins)
  @default_sort_symbols Application.get_env(@app, :default_sort_symbols)
  @options Application.get_env(@app, :options)

  @spec new() :: t
  def new(), do: init() |> update()

  @spec apply(t, Keyword.t()) :: t
  def apply(spec, []), do: spec

  def apply(spec, options) do
    spec = Enum.reduce(options, spec, &validate/2)

    options
    |> Keyword.keys()
    |> Enum.all?(&(&1 in [:bell, :count, :style]))
    |> if(do: spec, else: update(spec))
  end

  @spec deploy(t, [Access.container()]) :: t
  def deploy(spec, maps) do
    spec
    |> Row.rows(maps)
    |> Column.column_widths()
  end

  ## Private functions

  @spec init() :: t
  defp init() do
    %{
      align_attrs: [],
      align_specs: Config.align_specs(),
      bell: Config.bell(),
      column_widths: [],
      count: Config.count(),
      headers: Config.headers(),
      header_fixes: Config.header_fixes(),
      headings: [],
      left_margin: "",
      margins: Config.margins(),
      max_width: Config.max_width(),
      rows: [],
      sort_attrs: [],
      sort_specs: Config.sort_specs(),
      sort_symbols: Config.sort_symbols(),
      style: Config.style()
    }
  end

  @spec update(t) :: t
  defp update(spec) do
    spec
    |> header_fixes()
    |> sort_symbols()
    |> margins()
    |> Column.align_attrs()
    |> Column.sort_attrs()
    |> Column.left_margin()
    |> Heading.headings()
  end

  @spec header_fixes(t) :: t
  defp header_fixes(spec) do
    update_in(spec.header_fixes, &Map.merge(@default_header_fixes, &1))
  end

  @spec sort_symbols(t) :: t
  defp sort_symbols(spec) do
    update_in(spec.sort_symbols, &Keyword.merge(@default_sort_symbols, &1))
  end

  @spec margins(t) :: t
  defp margins(spec) do
    update_in(spec.margins, &Keyword.merge(@default_margins, &1))
  end

  @spec validate(tuple, t) :: t
  defp validate({key, value}, spec) when key in @options do
    %{spec | key => apply(Config, key, [value])}
  end

  defp validate({_key, _value}, spec), do: spec
end
