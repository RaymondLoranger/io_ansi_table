defmodule IO.ANSI.Table.Header do
  @moduledoc """
  Finds the align or sort attribute of a header.
  Also converts a header into a "heading".
  """

  alias IO.ANSI.Table.Spec

  @typedoc "Align atribute"
  @type align_attr :: :left | :center | :right
  @typedoc "Align spec"
  @type align_spec :: t | {align_attr, t}
  @typedoc "Sort atribute"
  @type sort_attr :: MapSorter.SortSpec.sort_dir()
  @typedoc "Sort spec"
  @type sort_spec :: MapSorter.SortSpec.t()
  @typedoc "Sort symbol"
  @type sort_symbol :: {sort_attr, String.t()} | {:pos, sym_pos | [sym_pos]}
  @typedoc "Symbol position"
  @type sym_pos :: :leading | :trailing
  @typedoc "Header"
  @type t :: Map.key()

  @doc """
  Finds the align or sort attribute of a `header`.
  
  ## Examples
  
      iex> alias IO.ANSI.Table.Header
      iex> sort_specs = ["dept", desc: "hired"]
      iex> {
      ...>   Header.find_attr("dept" , sort_specs, :asc),
      ...>   Header.find_attr("hired", sort_specs, :asc),
      ...>   Header.find_attr("job"  , sort_specs, :asc)
      ...> }
      {:asc, :desc, nil}
  
      iex> alias IO.ANSI.Table.Header
      iex> sort_specs = ["dept", desc: {"hired", Date}]
      iex> {
      ...>   Header.find_attr("dept" , sort_specs, :asc),
      ...>   Header.find_attr("hired", sort_specs, :asc),
      ...>   Header.find_attr("job"  , sort_specs, :asc)
      ...> }
      {:asc, :desc, nil}
  
      iex> alias IO.ANSI.Table.Header
      iex> sort_specs = [{"hired", Date}, "job", {:desc, "dept"}]
      iex> {
      ...>   Header.find_attr("dept" , sort_specs, :asc),
      ...>   Header.find_attr("hired", sort_specs, :asc),
      ...>   Header.find_attr("job"  , sort_specs, :asc)
      ...> }
      {:desc, :asc, :asc}
  
      iex> alias IO.ANSI.Table.Header
      iex> sort_specs = [{"hired", Date}, desc: "dept"]
      iex> {
      ...>   Header.find_attr("dept" , sort_specs, :asc),
      ...>   Header.find_attr("hired", sort_specs, :asc),
      ...>   Header.find_attr("job"  , sort_specs, :asc)
      ...> }
      {:desc, :asc, nil}
  
      iex> alias IO.ANSI.Table.Header
      iex> align_specs = ["dept", right: "hired"]
      iex> {
      ...>   Header.find_attr("dept" , align_specs, :left),
      ...>   Header.find_attr("hired", align_specs, :left),
      ...>   Header.find_attr("job"  , align_specs, :left)
      ...> }
      {:left, :right, nil}
  """
  @spec find_attr(t, [align_spec | sort_spec], :left | :asc) ::
          align_attr | sort_attr | nil
  def find_attr(header, specs, default_attr) do
    Enum.find_value(specs, fn
      # {:center, :dob} or {:desc, :dob}
      {attr, key} when key == header -> attr
      # {:dob, Date}
      {key, mod} when is_atom(mod) and key == header -> default_attr
      # {:desc, {:dob, Date}}
      {attr, {key, mod}} when is_atom(mod) and key == header -> attr
      # :dob
      key when key == header -> default_attr
      _ -> false
    end)
  end

  @doc """
  Converts a `header` into a "heading".
  
  ## Examples
  
      iex> alias IO.ANSI.Table.{Header, Spec}
      iex> spec = Spec.new([:col_4, :col_1, :col_2], sort_specs: [asc: :col_2])
      iex> Header.to_heading(:col_2, spec)
      "Col 2↑"
  """
  @spec to_heading(t, Spec.t()) :: String.t()
  def to_heading(header, spec) do
    sort_symbol(header, spec, :leading) <>
      titlecase(header, spec) <>
      sort_symbol(header, spec, :trailing)
  end

  ## Private functions

  @spec sort_symbol(t, Spec.t(), sym_pos) :: String.t()
  defp sort_symbol(header, spec, sym_pos) do
    pos_list = [spec.sort_symbols[:pos]] |> List.flatten()
    sort_dir = find_attr(header, spec.sort_specs, :asc)
    (sym_pos in pos_list && spec.sort_symbols[sort_dir]) || ""
  end

  @spec titlecase(t, Spec.t()) :: String.t()
  defp titlecase(header, spec)
       # string, atom or charlist
       when is_binary(header) or is_atom(header) or is_list(header) do
    title =
      header
      |> to_string()
      |> String.split(~r/(_| )+/, trim: true)
      |> Enum.map_join(" ", &title/1)

    Enum.reduce(spec.header_fixes, title, &fix/2)
  end

  defp titlecase(header, _spec), do: inspect(header)

  # title("MPH") => "MPH"
  # title("miles") => "Miles"
  @spec title(String.t()) :: String.t()
  defp title(word) do
    word
    |> String.first()
    |> String.upcase()
    |> Kernel.<>(String.slice(word, 1..-1))
  end

  # fix({" Of ", " of "}, "Nbr Of Yrs") => "Nbr of Yrs"
  @spec fix(tuple, String.t()) :: String.t()
  defp fix({key, value}, title), do: String.replace(title, key, value)
end
