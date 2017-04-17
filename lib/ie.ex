
defmodule IE do
  @moduledoc false

  alias IO.ANSI.Table.{Formatter, Style}

  # Functions for iex session...
  #
  # Examples:
  #   require IE
  #   IE.use
  #   print_people :green_mult
  #   print_people :green_mult, 9
  #   print_people :as_keywords, :black_mult
  #   print_people :as_keywords, :black_mult, 9
  #   styles()
  #   people()
  #   people :as_keywords
  #   people_sorted()
  #   key_for(List.first people())
  #   key_for(List.first people :as_keywords)

  defmacro use do
    quote do
      import IE
      alias IO.ANSI.Table.{Config, Formatter, Formatter.Helper, Style}
      :ok
    end
  end

  def people do
    [ %{name: "Mike", likes: "ski, arts", date_of_birth: "1992-04-15",
        height: ~s[6' 0"], weight: "176 lb", bmi: 23.9
      },
      %{name: "Mary", likes: "travels"  , date_of_birth: "1992-04-15",
        height: ~s[5' 6"], weight: "166 lb", bmi: 26.8
      },
      %{name: "Ann" , likes: "reading"  , date_of_birth: "1992-04-15",
        height: ~s[6' 1"], weight: "187 lb", bmi: 24.7
      },
      %{name: "Ray" , likes: "cycling"  , date_of_birth: "1977-08-28",
        height: ~s[6' 0"], weight: "141 lb", bmi: 19.1
      },
      %{name: "Bill", likes: "karate"   , date_of_birth: "1977-08-28",
        height: ~s[5' 8"], weight: "119 lb", bmi: 18.1
      },
      %{name: "Joe" , likes: "boxing"   , date_of_birth: "1977-08-28",
        height: "1.82 m", weight: "69 kg", bmi: 20.8
      },
      %{name: "Jill", likes: "cooking"  , date_of_birth: "1976-09-28",
        height: "1.76 m", weight: "80 kg", bmi: 25.8
      }
    ]
  end

  def people(:as_keywords) do
    Enum.map(IE.people, &Keyword.new/1) # people as keywords
  end

  def headers do
    [:name, :date_of_birth, :likes, :height, :weight, :bmi]
  end

  def key_headers do
    [:date_of_birth, :likes]
  end

  def header_fixes do
    %{~r/^bmi$/i => "BMI" ,
      ~r/ of /i  => " of "
    }
  end

  def margins do
    [top: 0, bottom: 0, left: 2]
  end

  def print_people(style) do
    Formatter.print_table(
      people(), length(people()), true, style,
      headers: headers(), key_headers: key_headers(),
      header_fixes: header_fixes(), margins: margins()
    )
  end

  def print_people(:as_keywords, style) do
    Formatter.print_table(
      people(:as_keywords), length(people()), true, style,
      headers: headers(), key_headers: key_headers(),
      header_fixes: header_fixes(), margins: margins()
    )
  end

  def print_people(style, max_width) do
    Formatter.print_table(
      people(), length(people()), true, style,
      headers: headers(), key_headers: key_headers(),
      header_fixes: header_fixes(), margins: margins(),
      max_width: max_width
    )
  end

  def print_people(:as_keywords, style, max_width) do
    Formatter.print_table(
      people(:as_keywords), length(people()), true, style,
      headers: headers(), key_headers: key_headers(),
      header_fixes: header_fixes(), margins: margins(),
      max_width: max_width
    )
  end

  def styles do
    format = IO.ANSI.format [
      :light_magenta, " &style&filler"  ,
      :reset        , " - &rank - &note"
    ]
    "#{format}"
    |> Style.texts(&IO.puts/1)
    |> length
  end

  def people_sorted do
    Enum.sort_by people(), &key_for/1
  end

  def key_for(person) do
    Formatter.key_for person, key_headers()
  end
end
