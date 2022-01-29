defmodule IO.ANSI.Table.Spec do
  @moduledoc """
  A table spec struct and functions for the IO ANSI Table app.
  
  The table spec struct contains the following fields:
  
  * initial fields:
  
    - `spec_name`,
    - `headers`,
    - `align_specs`,
    - `bell`,
    - `count`,
    - `header_fixes`,
    - `margins`,
    - `max_width`,
    - `sort_specs`,
    - `sort_symbols`,
    - `style`
  
  * derived fields:
  
    - `align_attrs`,
    - `headings`,
    - `left_margin`,
    - `sort_attrs`
  
  * data dependent fields:
  
    - `column_widths`
    - `rows`
  """

  use PersistConfig

  alias __MODULE__
  alias IO.ANSI.Plus, as: ANSI
  alias IO.ANSI.Table.{Column, Header, LineType, Row, Style}

  @default_bell get_env(:default_bell)
  @default_count get_env(:default_count)
  @default_margins get_env(:default_margins)
  @default_max_width get_env(:default_max_width)
  @default_sort_symbols get_env(:default_sort_symbols)
  @default_style get_env(:default_style)

  @enforce_keys [
    # initial fields
    :spec_name,
    :headers,
    :align_specs,
    :bell,
    :count,
    :header_fixes,
    :margins,
    :max_width,
    :sort_specs,
    :sort_symbols,
    :style
  ]
  defstruct [
    # initial fields
    :spec_name,
    :headers,
    :align_specs,
    :bell,
    :count,
    :header_fixes,
    :margins,
    :max_width,
    :sort_specs,
    :sort_symbols,
    :style,
    # derived fields
    align_attrs: [],
    headings: [],
    left_margin: "",
    sort_attrs: [],
    # data dependent fields
    column_widths: [],
    rows: []
  ]

  @typedoc "A table spec struct for the IO ANSI Table app"
  @type t :: %Spec{
          # initial fields
          spec_name: String.t(),
          headers: [Header.t(), ...],
          align_specs: [Header.align_spec()],
          bell: boolean,
          count: integer,
          header_fixes: %{optional(String.t() | Regex.t()) => String.t()},
          margins: Keyword.t(),
          max_width: pos_integer,
          sort_specs: [Header.sort_spec()],
          sort_symbols: [Header.sort_symbol()],
          style: Style.t(),
          # derived fields
          align_attrs: [Header.align_attr()],
          headings: [String.t()],
          left_margin: String.t(),
          sort_attrs: [Header.sort_attr()],
          # data dependent fields
          column_widths: [Column.width()],
          rows: [Row.t()]
        }

  @doc """
  Creates a table spec struct from `headers` and `options`.
  """
  @spec new([Header.t(), ...], Keyword.t()) :: t
  def new([_ | _] = headers, options \\ []) when is_list(options) do
    %Spec{
      spec_name: spec_name(options),
      headers: headers,
      align_specs: Keyword.get(options, :align_specs, []),
      bell: Keyword.get(options, :bell, @default_bell),
      count: Keyword.get(options, :count, @default_count),
      header_fixes: Keyword.get(options, :header_fixes, %{}),
      margins: Keyword.merge(@default_margins, options[:margins] || []),
      max_width: Keyword.get(options, :max_width, @default_max_width),
      sort_specs: Keyword.get(options, :sort_specs, []),
      sort_symbols:
        Keyword.merge(@default_sort_symbols, options[:sort_symbols] || []),
      style: Keyword.get(options, :style, @default_style)
    }
  end

  @doc """
  Updates the derived fields of `spec`.
  """
  @spec develop(t) :: t
  def develop(%Spec{} = spec) do
    spec
    |> Spec.AlignAttrs.derive_and_put()
    |> Spec.Headings.derive_and_put()
    |> Spec.LeftMargin.derive_and_put()
    |> Spec.SortAttrs.derive_and_put()
  end

  @doc """
  Gets the table spec server name in `options`.
  Defaults to the current app name expressed as a string.
  
  ## Examples
  
      iex> alias IO.ANSI.Table.Spec
      iex> Spec.spec_name(style: :light, count: 9, spec_name: "github_issues")
      "github_issues"
  
      iex> alias IO.ANSI.Table.Spec
      iex> Spec.spec_name([])
      "io_ansi_table"
  """
  @spec spec_name(Keyword.t()) :: String.t()
  def spec_name(options) when is_list(options) do
    case options[:spec_name] do
      nil ->
        case :application.get_application() do
          {:ok, app} -> app
          # Thanks to `use PersistConfig`...
          :undefined -> @app
        end
        |> to_string()

      spec_name when is_binary(spec_name) ->
        spec_name
    end
  end

  @doc """
  Writes data from `maps` to `:stdio` per table `spec` and `options`.
  """
  @spec write_table(t, [Access.container()], Keyword.t()) :: :ok
  def write_table(%Spec{} = spec, maps, options \\ [])
      when is_list(maps) and is_list(options) do
    spec
    |> put(:bell, options[:bell])
    |> put(:count, options[:count])
    |> put(:max_width, options[:max_width])
    |> put(:style, options[:style])
    |> Spec.Rows.derive_and_put(maps)
    |> Spec.ColumnWidths.derive_and_put()
    |> write_table()
  end

  ## Private functions

  @spec put(t, atom, Keyword.value()) :: t
  defp put(spec, _key, nil), do: spec
  defp put(spec, key, value), do: Map.put(spec, key, value)

  @spec top_margin(t) :: String.t()
  defp top_margin(%Spec{margins: margins} = _spec) do
    case margins[:top] do
      # Move the cursor up N lines: \e[<N>A...
      n when n <= -1 -> ANSI.cursor_up(-n)
      n -> String.duplicate("\n", n)
    end
  end

  @spec bottom_margin(t) :: String.t()
  defp bottom_margin(%Spec{margins: margins} = _spec) do
    case margins[:bottom] do
      n when n >= 0 -> String.duplicate("\n", n)
      _ -> ""
    end
  end

  @spec write_table(t) :: :ok
  defp write_table(spec) do
    top_margin(spec) |> IO.write()
    Style.line_types(spec.style) |> Enum.each(&LineType.write_lines(&1, spec))
    bottom_margin(spec) |> IO.write()
    IO.write(if spec.bell, do: "\a", else: "")
  end
end
