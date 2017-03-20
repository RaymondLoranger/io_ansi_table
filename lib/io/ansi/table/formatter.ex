
# Based on the book "Programming Elixir" by Dave Thomas.

defmodule IO.ANSI.Table.Formatter do
  @moduledoc """
  Prints a table applying a table style. Each row is
  a list of values identified by successive headers.
  """

  alias IO.ANSI.Table.Formatter.Helper
  alias IO.ANSI.Table.Style

  @app     Mix.Project.config[:app]
  @headers Application.get_env(@app, :table_headers)
  @key     Application.get_env(@app, :key_header)

  @doc """
  Takes a list of `key`-`value` `collections`, how many to format,
  whether to ring the bell, a table `style` and, as `options`, a list
  of `headers` (`keys`) and a key `header` to sort the `collections` on.

  Prints a table to STDOUT of the `values` in each `collection`.
  The columns are identified by successive `headers` in order.

  We calculate the width of each column to fit the longest element
  in that column, also considering the `header` itself.

  ## Parameters

    - `collections` - list of collections (maps or keywords)
    - `count`       - number of collections to format (integer)
    - `bell`        - ring the bell? (boolean)
    - `style`       - table style (atom)
    - `options`     - table headers and key header (keyword)

  ## Table styles

  #{Style.texts "  - `&style`&filler - &note\n"}
  ## Options

    - `:headers` - defaults to config value `:table_headers`
    - `:key`     - defaults to config value `:key_header`

  ## Examples

      alias IO.ANSI.Table.Formatter
      people = [
        %{name: "Mike", likes: "ski, arts", date_of_birth: "1992-04-15"},
        %{name: "Mary", likes: "reading"  , date_of_birth: "1985-07-11"},
        %{name: "Ray" , likes: "cycling"  , date_of_birth: "1977-08-28"}
      ]
      Formatter.print_table(
        people, 3, true, :dark,
        headers: [:name, :date_of_birth, :likes],
        key: :date_of_birth
      )
  ## ![print_table_people](images/print_table_people.png)
      iex> alias IO.ANSI.Table.Formatter
      iex> alias ExUnit.CaptureIO
      iex> people = [
      ...>   %{name: "Mike", likes: "ski, arts", date_of_birth: "1992-04-15"},
      ...>   %{name: "Mary", likes: "reading"  , date_of_birth: "1985-07-11"},
      ...>   %{name: "Ray" , likes: "cycling"  , date_of_birth: "1977-08-28"}
      ...> ]
      iex> CaptureIO.capture_io fn ->
      ...>   Formatter.print_table(
      ...>     people, 3, false, :dashed,
      ...>     headers: [:name, :date_of_birth, :likes],
      ...>     key: :date_of_birth
      ...>   )
      ...> end
      \"""
      +------+---------------+-----------+
      | Name | Date Of Birth | Likes     |
      +------+---------------+-----------+
      | Ray  | 1977-08-28    | cycling   |
      | Mary | 1985-07-11    | reading   |
      | Mike | 1992-04-15    | ski, arts |
      +------+---------------+-----------+
      \"""
  """
  @spec print_table([map | Keyword.t], integer, boolean, atom, Keyword.t)
    :: :ok
  def print_table(collections, count, bell, style, options \\ []) do
    headers = Keyword.get(options, :headers, @headers)
    key = Keyword.get(options, :key, @key)
    collections =
      collections
      |> Stream.map(&Map.take &1, headers) # optional
      |> Enum.sort(&(&1[key] <= &2[key]))
      |> Enum.take(count)
    widths =
      [Map.new(headers, &{&1, titlecase &1}) | collections]
      |> columns(headers)
      |> widths # => max widths of column values or headers
    rows = rows(collections, headers)
    Helper.print_table(rows, headers, key, widths, style, bell)
  end

  @doc """
  Takes a list of `key`-`value` `collections` and a list of `keys`.

  Returns a list of columns, each column being a list of string `values`
  selected from each `collection` on a given `key` and repeatedly on
  successive `keys` in order.

  ## Examples

      iex> alias IO.ANSI.Table.Formatter
      iex> list = [
      ...>   %{"a" => "1", "b" => "2", "c" => "3"},
      ...>   %{"a" => "4", "b" => "5", "c" => "6"}
      ...> ]
      iex> Formatter.columns(list, ["c", "a"])
      [["3", "6"], ["1", "4"]]

      iex> alias IO.ANSI.Table.Formatter
      iex> list = [
      ...>   %{:one => "1", '2' => 2.0, 3 => :three},
      ...>   %{:one => '4', '2' => "5", 3 => 000006}
      ...> ]
      iex> Formatter.columns(list, [3, :one, '2'])
      [["three", "6"], ["1", "4"], ["2.0", "5"]]
  """
  @spec columns([map | Keyword.t], [any]) :: [[String.t]]
  def columns(collections, keys) do
    for key <- keys do
      for collection <- collections, do: to_string(collection[key])
    end
  end

  @doc """
  Takes a list of `key`-`value` `collections` and a list of `keys`.

  Returns a list of rows, each row being a list of string `values`
  orderly selected on successive `keys` from a given `collection` and
  repeatedly for each `collection` in turn.

  ## Examples

      iex> alias IO.ANSI.Table.Formatter
      iex> list = [
      ...>   %{"a" => "1", "b" => "2", "c" => "3"},
      ...>   %{"a" => "4", "b" => "5", "c" => "6"}
      ...> ]
      iex> Formatter.rows(list, ["c", "a"])
      [["3", "1"], ["6", "4"]]

      iex> alias IO.ANSI.Table.Formatter
      iex> list = [
      ...>   %{:one => "1", '2' => 2.0, 3 => :three},
      ...>   %{:one => '4', '2' => "5", 3 => 000006}
      ...> ]
      iex> Formatter.rows(list, [3, :one, '2'])
      [["three", "1", "2.0"], ["6", "4", "5"]]
  """
  @spec rows([map | Keyword.t], [any]) :: [[String.t]]
  def rows(collections, keys) do
    for collection <- collections do
      for key <- keys, do: to_string(collection[key])
    end
  end

  @doc """
  Given a list of sublists, where each sublist contains the strings of
  a `column`, returns a list containing the maximum width of each `column`.

  ## Examples

      iex> alias IO.ANSI.Table.Formatter
      iex> data = [["cat", "wombat", "elk"], ["mongoose", "ant", "gnu"]]
      iex> Formatter.widths(data)
      [6, 8]

      iex> alias IO.ANSI.Table.Formatter
      iex> data = [[":cat", "{1, 2}", "007"], ["mongoose", ":ant", "3.1416"]]
      iex> Formatter.widths(data)
      [6, 8]
  """
  @spec widths([[String.t]]) :: [non_neg_integer]
  def widths(columns) do
    for column <- columns, do: column |> Enum.map(&String.length/1) |> Enum.max
  end

  @doc """
  Capitalizes every word of a `title` (converted to string if applicable).

  Any underscore is considered a space and consecutive
  whitespace characters are treated as a single occurrence.
  Leading and trailing whitespace characters are removed.

  ## Examples

      iex> alias IO.ANSI.Table.Formatter
      iex> Formatter.titlecase(" son   of a gun ")
      "Son Of A Gun"

      iex> alias IO.ANSI.Table.Formatter
      iex> Formatter.titlecase("_date___of_birth_")
      "Date Of Birth"

      iex> alias IO.ANSI.Table.Formatter
      iex> Formatter.titlecase(:" _aN_ _oDD cASe_ ")
      "An Odd Case"
  """
  @spec titlecase(any) :: String.t
  def titlecase(title) do
    title
    |> to_string
    |> String.split(~r/(_|\s)+/, trim: true)
    |> Enum.map(&String.capitalize/1)
    |> Enum.join(" ")
  end
end
