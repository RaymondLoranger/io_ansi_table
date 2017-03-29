
defmodule IO.ANSI.Table do
  @moduledoc false

  # Functions for iex session...
  # E.g. IO.ANSI.Table.print_people :green_mult

  def people do
    [
      %{
        name: "Mike", likes: "ski, arts", date_of_birth: "1992-04-15",
        height: ~s[6' 0"], weight: "176 lb", bmi: 23.9
      },
      %{
        name: "Mary", likes: "travels"  , date_of_birth: "1992-04-15",
        height: ~s[5' 6"], weight: "166 lb", bmi: 26.8
      },
      %{
        name: "Ann" , likes: "reading"  , date_of_birth: "1992-04-15",
        height: ~s[6' 1"], weight: "187 lb", bmi: 24.7
      },
      %{
        name: "Ray" , likes: "cycling"  , date_of_birth: "1977-08-28",
        height: ~s[6' 0"], weight: "141 lb", bmi: 19.1
      },
      %{
        name: "Bill", likes: "karate"   , date_of_birth: "1977-08-28",
        height: ~s[5' 8"], weight: "119 lb", bmi: 18.1
      },
      %{
        name: "Joe" , likes: "boxing"   , date_of_birth: "1977-08-28",
        height: "1.82 m", weight: "69 kg", bmi: 20.8
      },
      %{
        name: "Jill", likes: "cooking"  , date_of_birth: "1976-09-28",
        height: "1.76 m", weight: "80 kg", bmi: 25.8
      }
    ]
  end

  def headers do
    [:name, :date_of_birth, :likes, :height, :weight, :bmi]
  end

  def key_headers do
    [:date_of_birth, :likes]
  end

  def header_terms do
    ["BMI", " of "]
  end

  def margins do
    [top: 2, bottom: 2, left: 3]
  end

  def print_people(style) do
    alias IO.ANSI.Table.Formatter
    Formatter.print_table(
      people(), 11, true, style,
      headers: headers(), key_headers: key_headers(),
      header_terms: header_terms(), margins: margins()
    )
  end

  def people_sorted do
    Enum.sort_by people(), &key_for/1
  end

  def key_for(person) do
    Enum.map_join key_headers(), &person[&1]
  end
end
