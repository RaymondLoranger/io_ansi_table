
defmodule IO.ANSI.Table do
  @moduledoc false

  # Functions for iex session...
  # E.g. IO.ANSI.Table.print_people :green_mult

  def people do
    [
      %{
        name: "Mike", likes: "ski, arts", date_of_birth: "1992-04-15",
        height: ~s[6' 0"], weight: "176 lb"
      },
      %{
        name: "Mary", likes: "travels"  , date_of_birth: "1992-04-15",
        height: ~s[5' 6"], weight: "166 lb"
      },
      %{
        name: "Ann" , likes: "reading"  , date_of_birth: "1992-04-15",
        height: ~s[6' 1"], weight: "187 lb"
      },
      %{
        name: "Ray" , likes: "cycling"  , date_of_birth: "1977-08-28",
        height: ~s[6' 0"], weight: "141 lb"
      },
      %{
        name: "Bill", likes: "karate"   , date_of_birth: "1977-08-28",
        height: ~s[5' 8"], weight: "119 lb"
      },
      %{
        name: "Joe" , likes: "boxing"   , date_of_birth: "1977-08-28",
        height: "1.82 m", weight: "69 kg"
      },
      %{
        name: "Jill", likes: "cooking"  , date_of_birth: "1976-09-28",
        height: "1.76 m", weight: "80 kg"
      }
    ]
  end

  def headers do
    [:name, :date_of_birth, :likes, :height, :weight]
  end

  def key_headers do
    [:date_of_birth, :likes]
  end

  def print_people(style) do
    alias IO.ANSI.Table.Formatter
    Formatter.print_table(
      people(), 11, true, style,
      headers: headers(), key_headers: key_headers()
    )
  end

  def people_sorted do
    Enum.sort_by people(), &key_for/1
  end

  def key_for(person) do
    Enum.map_join key_headers(), &person[&1]
  end
end
