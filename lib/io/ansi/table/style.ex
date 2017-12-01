defmodule IO.ANSI.Table.Style do
  # @moduledoc """
  # Defines functions returning the properties of configured table styles.
  # """
  @moduledoc false

  use PersistConfig

  alias IO.ANSI.Table.{Column, LineType}

  @type attr :: atom | [atom]
  @type border :: String.t
  @type t :: atom

  @styles Application.get_env(@app, :table_styles)

  Module.register_attribute(__MODULE__, :inner_lengths, accumulate: true)
  Module.register_attribute(__MODULE__, :left_lengths, accumulate: true)
  Module.register_attribute(__MODULE__, :line_types, accumulate: true)
  Module.register_attribute(__MODULE__, :right_lengths, accumulate: true)
  Module.register_attribute(__MODULE__, :style_ids, accumulate: true)
  Module.register_attribute(__MODULE__, :style_lengths, accumulate: true)
  Module.register_attribute(__MODULE__, :types, accumulate: true)

  @doc """
  Converts a switch `argument` to a table style.

  ## Examples

      iex> alias IO.ANSI.Table.Style
      iex> Style.from_switch_arg("green-alt")
      {:ok, :green_alt}

      iex> alias IO.ANSI.Table.Style
      iex> Style.from_switch_arg("lite")
      :error
  """
  @spec from_switch_arg(String.t) :: {:ok, t} | :error
  def from_switch_arg(arg)

  @doc """
  Converts a table `style` to a switch argument.

  ## Examples

      iex> alias IO.ANSI.Table.Style
      iex> Style.to_switch_arg(:green_alt)
      "green-alt"

      iex> alias IO.ANSI.Table.Style
      iex> Style.to_switch_arg(:lite)
      nil
  """
  @spec to_switch_arg(t) :: String.t | nil
  def to_switch_arg(style)

  for {style, %{}} <- @styles do
    @style_ids style
    @style_lengths style |> inspect() |> String.length()
    arg = style |> to_string() |> String.replace("_", "-")
    def from_switch_arg(unquote(arg)), do: {:ok, unquote(style)}
    def to_switch_arg(unquote(style)), do: unquote(arg)
  end
  def from_switch_arg(_arg), do: :error
  def to_switch_arg(_style), do: nil

  @max_length Enum.max(@style_lengths)

  @doc """
  Returns the list of all table styles.

  ## Examples

      iex> alias IO.ANSI.Table.Style
      iex> Style.styles() |> length()
      40
  """
  @spec styles() :: [t]
  def styles(), do: Enum.sort(@style_ids)

  @doc """
  Returns the dash of a given table `style` and line `type`.

  ## Examples

      iex> IO.ANSI.Table.Style
      iex> Style.dash(:dark, :top)
      "═"

      iex> IO.ANSI.Table.Style
      iex> Style.dash(:dark, :row)
      nil
  """
  @spec dash(t, LineType.t) :: String.t | nil
  def dash(style, type)

  @doc """
  Returns the borders of a given table `style` and line `type`.

  ## Examples

      iex> alias IO.ANSI.Table.Style
      iex> Style.borders(:cyan, :bottom)
      ["╚═", "═╩═", "═╝"]
  """
  @spec borders(t, LineType.t) :: [border] | []
  def borders(style, type)

  @doc """
  Returns the border spreads of a given table `style` and line `type`.

  ## Examples

      iex> alias IO.ANSI.Table.Style
      iex> Style.border_spreads(:plain, :bottom)
      [[0, 2, 0], [0, 3, 0], [0, 2, 0]] # borders: "└─", "─┴─", "─┘"

      iex> alias IO.ANSI.Table.Style
      iex> Style.border_spreads(:plain, :header)
      [[0, 1, 1], [1, 1, 1], [1, 1, 0]] # borders: "│" ,  "│" ,  "│"
  """
  @spec border_spreads(t, LineType.t) :: [Column.spread] | []
  def border_spreads(style, type)

  @doc """
  Returns the line types of a given table `style`.

  ## Examples

      iex> alias IO.ANSI.Table.Style
      iex> Style.line_types(:light)
      [:top, :header, :separator, [:row], :bottom]

      iex> alias IO.ANSI.Table.Style
      iex> Style.line_types(:green_alt)
      [:top, :header, :separator, [:even_row, :odd_row]]
  """
  @spec line_types(t) :: [LineType.t] | []
  def line_types(style)

  for {style, %{borders: borders}} <- @styles do
    for {type, [left, inner, right, dash]} <- borders do
      @left_lengths String.length(left)
      @inner_lengths String.length(inner)
      @right_lengths String.length(right)
      @types type
      def dash(unquote(style), unquote(type)), do: unquote(dash)
      def borders(unquote(style), unquote(type)) do
        [unquote(left), unquote(inner), unquote(right)]
      end
    end

    @max_left_length Enum.max(@left_lengths)
    @max_inner_length Enum.max(@inner_lengths)
    @max_right_length Enum.max(@right_lengths)

    for {type, [left, inner, right, _dash]} <- borders do
      left_spread = Column.spread(@max_left_length, left, :left)
      inner_spread = Column.spread(@max_inner_length, inner, :center)
      right_spread = Column.spread(@max_right_length, right, :right)
      def border_spreads(unquote(style), unquote(type)) do
        [unquote(left_spread), unquote(inner_spread), unquote(right_spread)]
      end
    end

    @line_types {style, LineType.to_line_types(@types)}
    def line_types(unquote(style)), do: @line_types[unquote(style)]

    Module.delete_attribute(__MODULE__, :left_lengths)
    Module.delete_attribute(__MODULE__, :inner_lengths)
    Module.delete_attribute(__MODULE__, :right_lengths)
    Module.delete_attribute(__MODULE__, :types)
  end
  def dash(_style, _type), do: nil
  def borders(_style, _type), do: []
  def border_spreads(_style, _type), do: []
  def line_types(_style), do: []

  @doc """
  Returns the border attribute of a given table `style` and line `type`.

  ## Examples

      iex> alias IO.ANSI.Table.Style
      iex> Style.border_attr(:green, :top)
      [:light_yellow, :light_green_background]
  """
  @spec border_attr(t, LineType.t) :: attr | nil
  def border_attr(style, type)

  @doc """
  Returns the filler attribute of a given table `style` and line `type`.

  ## Examples

      iex> alias IO.ANSI.Table.Style
      iex> Style.filler_attr(:mixed, :row)
      :light_green_background
  """
  @spec filler_attr(t, LineType.t) :: attr | nil
  def filler_attr(style, type)

  @doc """
  Returns the key attribute of a given table `style` and line `type`.

  ## Examples

      iex> alias IO.ANSI.Table.Style
      iex> Style.key_attr(:light, :row)
      :light_cyan

      iex> alias IO.ANSI.Table.Style
      iex> Style.key_attr(:light, :header)
      [:light_yellow, :underline]
  """
  @spec key_attr(t, LineType.t) :: attr | nil
  def key_attr(style, type)

  @doc """
  Returns the non key attribute of a given table `style` and line `type`.

  ## Examples

      iex> alias IO.ANSI.Table.Style
      iex> Style.non_key_attr(:cyan, :row)
      [:black, :light_cyan_background]
  """
  @spec non_key_attr(t, LineType.t) :: attr | nil
  def non_key_attr(style, type)

  @attr_funs [:border_attr, :filler_attr, :key_attr, :non_key_attr]

  for fun <- @attr_funs do
    key = "#{fun}s" |> String.to_atom()
    for {style, style_map} <- @styles do
      attrs = Map.get(style_map, key)
      case attrs do
        attrs when is_list(attrs) and length(attrs) > 2 ->
          for {type, attr} <- attrs do
            def unquote(fun)(unquote(style), unquote(type)), do: unquote(attr)
          end
        attr ->
          for type <- List.flatten(@line_types[style]) do
            def unquote(fun)(unquote(style), unquote(type)), do: unquote(attr)
          end
      end
    end
    def unquote(fun)(_style, _type), do: nil
  end

  @doc ~S"""
  Returns a list of interpolated texts (one per table style)
  and optionally passes each one to a function.

  ## Examples

      alias IO.ANSI.Table.Style
      Style.texts("  - `&style`&filler - &note\n")

      alias IO.ANSI.Table.Style
      Style.texts("  - `&style`&filler - &note", &IO.puts/1)

  ## Interpolation placeholders

    - `&style`  - table style (e.g. ":light_alt")
    - `&arg`    - table style switch arg (e.g. "light-alt")
    - `&filler` - padding after &style or &arg
    - `&note`   - table style note
    - `&rank`   - table style rank (3 digits)
  """
  @spec texts(String.t, (String.t -> any)) :: [any]
  def texts(template, fun \\ & &1) when is_function(fun, 1) do
    @styles
    |> Enum.sort(& elem(&1, 0) <= elem(&2, 0))
    |> Stream.map(&interpolate(&1, template))
    |> Enum.map(&fun.(&1))
  end

  ## Private functions

  @spec interpolate({t, map}, String.t) :: String.t
  defp interpolate({style, %{note: note, rank: rank}}, template) do
    import String, only: [duplicate: 2, replace: 3, slice: 2]

    {style, arg} = {inspect(style), to_switch_arg(style)}
    filler = duplicate(" ", @max_length - String.length(style))
    template
    |> replace("&style", style)
    |> replace("&arg", arg)
    |> replace("&filler", filler)
    |> replace("&note", note)
    |> replace("&rank", slice("0#{rank}", -3..-1)) # last 3 digits
    |> replace(~r/ +. *$/u, "") # e.g. erase trailing " - "
    |> replace(~r/ +\(\) *$/, "") # erase trailing " () "
  end
end
