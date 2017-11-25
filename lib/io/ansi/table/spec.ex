defmodule IO.ANSI.Table.Spec do
  # @moduledoc """
  # Holds the specification of the table to be formatted.
  # """
  @moduledoc false

  use PersistConfig

  alias IO.ANSI.Table.{Column, Config, Heading, Row}

  @type t :: map

  @default_header_fixes Application.get_env(@app, :default_header_fixes)
  @default_margins Application.get_env(@app, :default_margins)
  @default_sort_symbols Application.get_env(@app, :default_sort_symbols)
  @options Application.get_env(@app, :options)

  @spec new() :: t
  def new(), do: init() |> update()

  @spec apply(t, Keyword.t) :: t
  def apply(spec, options) do
    spec = options |> Enum.reduce(spec, &validate/2)
    if skip_update?(options), do: spec, else: update(spec)
  end

  @spec deploy(Spec.t, [Access.container]) :: Spec.t
  def deploy(spec, maps) do
    spec
    |> Row.rows(maps)
    |> Column.column_widths()
  end

  ## Private functions

  @spec skip_update?(Keyword.t) :: boolean
  defp skip_update?(options) do
    options |> Keyword.keys() |> Enum.all?(& &1 in [:bell, :count, :style])
  end

  @spec init() :: t
  defp init() do
    %{
      align_specs: Config.align_specs(),
      bell: Config.bell(),
      count: Config.count(),
      headers: Config.headers(),
      header_fixes: Config.header_fixes(),
      margins: Config.margins(),
      max_width: Config.max_width(),
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
    header_fixes = Map.merge(@default_header_fixes, spec.header_fixes)
    Map.put(spec, :header_fixes, header_fixes)
  end

  @spec sort_symbols(t) :: t
  defp sort_symbols(spec) do
    sort_symbols = Keyword.merge(@default_sort_symbols, spec.sort_symbols)
    Map.put(spec, :sort_symbols, sort_symbols)
  end

  @spec margins(t) :: t
  defp margins(spec) do
    margins = Keyword.merge(@default_margins, spec.margins)
    Map.put(spec, :margins, margins)
  end

  @spec validate(tuple, Spec.t) :: Spec.t
  defp validate({key, value}, spec) when key in @options do
    Map.put(spec, key, apply(Config, key, [value]))
  end
  defp validate({_key, _value}, spec), do: spec
end
