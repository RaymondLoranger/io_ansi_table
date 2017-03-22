
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
      iex> Style.for("light")
      {:ok, :light}
  """
  @spec for(String.t) :: {:ok, atom} | :error
  def for(tag)

  for {style, %{}} <- @styles do
    @style_lengths String.length(inspect style)
    def for(unquote to_string style), do: {:ok, unquote style}
  end
  def for(_tag), do: :error

  @max_length Enum.max @style_lengths

  @doc """
  Retrieves the dash of a given table `style` and line `type`.

  ## Examples

      iex> IO.ANSI.Table.Style
      iex> Style.dash(:dark, :top)
      "═"
  """
  @spec dash(atom, atom) :: String.t | nil
  def dash(style, type)

  @doc """
  Retrieves the borders of a given table `style` and line `type`.

  ## Examples

      iex> alias IO.ANSI.Table.Style
      iex> Style.borders(:cyan, :bottom)
      {"╚═", "═╩═", "═╝"}
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
  Retrieves the border widths of a given table `style` and line `type`.

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
  Retrieves the border attribute of a given table `style`.

  ## Examples

      iex> alias IO.ANSI.Table.Style
      iex> Style.border_attr(:green)
      [:light_yellow, :light_green_background]
  """
  @spec border_attr(atom) :: [atom] | atom | nil
  def border_attr(style)

  @doc """
  Retrieves the filler attribute of a given table `style`.

  ## Examples

      iex> alias IO.ANSI.Table.Style
      iex> Style.filler_attr(:mixed)
      :light_green_background
  """
  @spec filler_attr(atom) :: [atom] | atom | nil
  def filler_attr(style)

  @doc """
  Retrieves the key attribute of a given table `style` and line `type`.

  ## Examples

      iex> alias IO.ANSI.Table.Style
      iex> Style.key_attr(:light, :data)
      :light_cyan
  """
  @spec key_attr(atom, atom) :: [atom] | atom | nil
  def key_attr(style, type)

  @doc """
  Retrieves the non key attribute of a given table `style` and line `type`.

  ## Examples

      iex> alias IO.ANSI.Table.Style
      iex> Style.non_key_attr(:cyan, :data)
      [:black, :light_cyan_background]
  """
  @spec non_key_attr(atom, atom) :: [atom] | atom | nil
  def non_key_attr(style, type)

  for {style, %{attrs: attrs}} <- @styles do
    for {:border, attr} <- attrs do
      def border_attr(unquote style), do: unquote(attr)
    end
    for {:filler, attr} <- attrs do
      def filler_attr(unquote style), do: unquote(attr)
    end
    for {type, {key, non_key}} <- attrs do
      def key_attr(unquote(style), unquote(type)), do: unquote(key)
      def non_key_attr(unquote(style), unquote(type)), do: unquote(non_key)
    end
  end
  def key_attr(style, type) when type in [:top, :separator, :bottom],
    do: border_attr(style)
  def key_attr(_style, _type), do: nil
  def non_key_attr(style, type) when type in [:top, :separator, :bottom],
    do: border_attr(style)
  def non_key_attr(_style, _type), do: nil
  def border_attr(_style), do: nil
  def filler_attr(_style), do: nil

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
    {style, tag, rank} = {inspect(style), to_string(style), to_string(rank)}
    filler = String.duplicate "\s", @max_length - String.length(style)
    template
    |> String.replace("&style", style)
    |> String.replace("&tag", tag)
    |> String.replace("&filler", filler)
    |> String.replace("&note", note)
    |> String.replace("&rank", rank)
    |> String.replace(~r/ +. *$/u, "") # e.g. erase trailing string " - "
    |> String.replace(~r/ +\(\) *$/, "") # erase trailing string " () "
  end
end
