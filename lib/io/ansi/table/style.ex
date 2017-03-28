
defmodule IO.ANSI.Table.Style do
  @moduledoc """
  Defines functions to retrieve properties of predefined table styles.
  """

  Mix.Project.config[:config_path] |> Mix.Config.read! |> Mix.Config.persist
  @external_resource Path.expand Mix.Project.config[:config_path]
  @app               Mix.Project.config[:app]
  @styles            Application.get_env(@app, :table_styles)

  Module.register_attribute __MODULE__, :style_lengths, accumulate: true

  @doc """
  Retrieves the table `style` for a given table style `tag`.

  ## Examples

      iex> alias IO.ANSI.Table.Style
      iex> Style.style_for("light")
      {:ok, :light}

      iex> alias IO.ANSI.Table.Style
      iex> Style.style_for("green-alt")
      {:ok, :green_alt}
  """
  @spec style_for(String.t) :: {:ok, atom} | :error
  def style_for(tag)

  @doc """
  Retrieves the table style `tag` for a given table `style`.

  ## Examples

      iex> alias IO.ANSI.Table.Style
      iex> Style.tag_for(:light)
      "light"

      iex> alias IO.ANSI.Table.Style
      iex> Style.tag_for(:green_alt)
      "green-alt"
  """
  @spec tag_for(atom) :: String.t | nil
  def tag_for(style)

  for {style, %{}} <- @styles do
    @style_lengths String.length(inspect style)
    tag = String.replace to_string(style), "_", "-"
    def style_for(unquote tag), do: {:ok, unquote style}
    def tag_for(unquote style), do: unquote(tag)
  end
  def style_for(_tag), do: :error
  def tag_for(_style), do: nil

  @max_length Enum.max @style_lengths

  @doc """
  Retrieves the line types of a given table `style`.

  ## Examples

      iex> alias IO.ANSI.Table.Style
      iex> Style.line_types(:light)
      [:top, :header, :separator, [:row], :bottom]

      iex> alias IO.ANSI.Table.Style
      iex> Style.line_types(:green_alt)
      [:top, :header, :separator, [:even_row, :odd_row]]
  """
  @spec line_types(atom) :: [atom] | nil
  def line_types(style)

  for {style, %{line_types: line_types}} <- @styles do
    def line_types(unquote style), do: unquote(line_types)
  end
  def line_types(_style), do: nil

  @doc """
  Retrieves the dash of a given table `style` and line/row `type`.

  ## Examples

      iex> IO.ANSI.Table.Style
      iex> Style.dash(:dark, :top)
      "═"

      iex> IO.ANSI.Table.Style
      iex> Style.dash(:dark, :row)
      nil
  """
  @spec dash(atom, atom) :: String.t | nil
  def dash(style, type)

  @doc """
  Retrieves the borders of a given table `style` and line/row `type`.

  ## Examples

      iex> alias IO.ANSI.Table.Style
      iex> Style.borders(:cyan, :bottom)
      {"╚═", "═╩═", "═╝"}

      iex> alias IO.ANSI.Table.Style
      iex> Style.borders(:cyan, :row)
      {"║", "║", "║"}
  """
  @spec borders(atom, atom) :: {String.t, String.t, String.t} | nil
  def borders(style, type)

  for {style, %{borders: borders}} <- @styles do
    for {type, {left, inner, right, dash}} <- borders do
      def dash(unquote(style), unquote(type)), do: unquote(dash)
      def borders(unquote(style), unquote(type)) do
        {unquote(left), unquote(inner), unquote(right)}
      end
    end
  end
  def dash(_style, _type), do: nil
  def borders(_style, _type), do: nil

  @doc """
  Retrieves the border widths of a given table `style` and line/row `type`.

  ## Examples

      iex> alias IO.ANSI.Table.Style
      iex> Style.border_widths(:plain, :bottom)
      {[2, 0], [0, 3, 0], [0, 2]}

      iex> alias IO.ANSI.Table.Style
      iex> Style.border_widths(:plain, :header)
      {[1, 1], [1, 1, 1], [1, 1]}
  """
  @spec border_widths(atom, atom) :: {[...], [...], [...]} | nil
  def border_widths(style, type)

  for {style, %{border_widths: border_widths}} <- @styles do
    for {type, {left, inner, right}} <- border_widths do
      def border_widths(unquote(style), unquote(type)) do
        {unquote(left), unquote(inner), unquote(right)}
      end
    end
  end
  def border_widths(_style, _type), do: nil

  @doc """
  Retrieves the border attribute of a given table `style` and line/row `type`.

  ## Examples

      iex> alias IO.ANSI.Table.Style
      iex> Style.border_attr(:green, :top)
      [:light_yellow, :light_green_background]
  """
  @spec border_attr(atom, atom) :: [atom] | atom | nil
  def border_attr(style, type)

  for {style, %{border_attrs: border_attrs}} <- @styles do
    for {type, border_attr} <- border_attrs do
      def border_attr(unquote(style), unquote(type)), do: unquote(border_attr)
    end
  end
  def border_attr(_style, _type), do: nil

  @doc """
  Retrieves the filler attribute of a given table `style` and line/row `type`.

  ## Examples

      iex> alias IO.ANSI.Table.Style
      iex> Style.filler_attr(:mixed, :separator)
      :light_green_background
  """
  @spec filler_attr(atom, atom) :: [atom] | atom | nil
  def filler_attr(style, type)

  for {style, %{filler_attrs: filler_attrs}} <- @styles do
    for {type, filler_attr} <- filler_attrs do
      def filler_attr(unquote(style), unquote(type)), do: unquote(filler_attr)
    end
  end
  def filler_attr(_style, _type), do: nil

  @doc """
  Retrieves the key attribute of a given table `style` and line/row `type`.

  ## Examples

      iex> alias IO.ANSI.Table.Style
      iex> Style.key_attr(:light, :row)
      :light_cyan

      iex> alias IO.ANSI.Table.Style
      iex> Style.key_attr(:light, :header)
      [:light_yellow, :underline]
  """
  @spec key_attr(atom, atom) :: [atom] | atom | nil
  def key_attr(style, type)

  for {style, %{key_attrs: key_attrs}} <- @styles do
    for {type, key_attr} <- key_attrs do
      def key_attr(unquote(style), unquote(type)) do
        unquote(key_attr)
      end
    end
  end
  def key_attr(_style, _type), do: nil

  @doc """
  Retrieves the non key attribute of a given table `style` and line/row `type`.

  ## Examples

      iex> alias IO.ANSI.Table.Style
      iex> Style.non_key_attr(:cyan, :row)
      [:black, :light_cyan_background]
  """
  @spec non_key_attr(atom, atom) :: [atom] | atom | nil
  def non_key_attr(style, type)

  for {style, %{non_key_attrs: non_key_attrs}} <- @styles do
    for {type, non_key_attr} <- non_key_attrs do
      def non_key_attr(unquote(style), unquote(type)) do
        unquote(non_key_attr)
      end
    end
  end
  def non_key_attr(_style, _type), do: nil

  @doc ~S"""
  Retrieves a list of interpolated texts (one per table style)
  and optionally passes each interpolated text to a function.

  ## Examples

      alias IO.ANSI.Table.Style
      Style.texts "  - `&style`&filler - &note\n"

      alias IO.ANSI.Table.Style
      Style.texts "  - `&style`&filler - &note", &IO.puts/1

  ## Interpolation placeholders

    - `&style`  - table style (e.g. ":light")
    - `&tag`    - table style tag (e.g. "light")
    - `&filler` - padding after &style or &tag
    - `&note`   - table style note
    - `&rank`   - table style rank
  """
  @spec texts(String.t, (String.t -> any)) :: [any]
  def texts(template, fun \\ &(&1)) when is_function(fun, 1) do
    @styles
    |> Enum.sort(&(elem(&1, 1).rank <= elem(&2, 1).rank))
    |> Enum.map(&interpolate &1, template)
    |> Enum.map(&fun.(&1))
  end

  @spec interpolate({atom, map}, String.t) :: String.t
  defp interpolate({style, %{note: note, rank: rank}}, template) do
    {style, tag, rank} = {inspect(style), tag_for(style), to_string(rank)}
    filler = String.duplicate "\s", @max_length - String.length(style)
    template
    |> String.replace("&style", style)
    |> String.replace("&tag", tag)
    |> String.replace("&filler", filler)
    |> String.replace("&note", note)
    |> String.replace("&rank", rank)
    |> String.replace(~r/ +. *$/u, "") # e.g. erase trailing " - "
    |> String.replace(~r/ +\(\) *$/, "") # erase trailing " () "
  end
end
