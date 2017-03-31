
# IO ANSI Table

Prints data to STDOUT in a table with borders and colors.
Can choose a table style among the 25 already predefined.

## Using

To use `IO ANSI Table` in your Mix project, first add it as a dependency:

```elixir
def deps do
  [{:io_ansi_table, "~> 0.1", app: false}]
end
```

Then run `mix deps.get` to install all dependencies or more specifically:
  - `mix deps.get io_ansi_table`
  - `mix deps.update io_ansi_table` (if required)
  - `mix deps.unlock io_ansi_table` (if required)
  - `mix deps.compile io_ansi_table` (if required)

In your project's `config/config.exs` file, you should then configure:
  - headers
  - header fixes
  - key headers
  - margins

Here is an example, if your table relates to NOAA Observations:

```elixir
config :io_ansi_table, headers: [
  "station_id", "weather", "temperature_string", "wind_mph",
  "location", "observation_time_rfc822"
]

config :io_ansi_table, header_fixes: %{
  ~r[\sid$]i       => "\sID",
  ~r[\smph$]i      => "\sMPH",
  ~r[\srfc(\d+)$]i => "\sRFC-\\1"
}

config :io_ansi_table, key_headers: ["temperature_string", "wind_mph"]
```

Here is an example to position the table by specifying up to 3 margins:

```elixir
config :io_ansi_table, margins: [
  top:    1, # line(s) before table
  bottom: 1, # line(s) after table
  left:   2  # space(s) left of table
]
```

The above margins represent the default table position.

## Example

```elixir
config :io_ansi_table, headers: [:name, :date_of_birth, :likes]
config :io_ansi_table, header_fixes: %{~r[\sof\s]i => "\sof\s"}
config :io_ansi_table, key_headers: [:date_of_birth]
config :io_ansi_table, margins: [
  top:    2, # line(s) before table
  bottom: 2, # line(s) after table
  left:   2  # space(s) left of table
]
```

```elixir
alias IO.ANSI.Table.Formatter
people = [
  %{name: "Mike", likes: "ski, arts", date_of_birth: "1992-04-15"},
  %{name: "Mary", likes: "reading"  , date_of_birth: "1985-07-11"},
  %{name: "Ray" , likes: "cycling"  , date_of_birth: "1977-08-28"}
]
Formatter.print_table(people, 3, true, :dark)
```
## ![print_table_people](images/print_table_people.png)

N.B. If you are on Windows, run command `chcp 65001` for the UTF-8 code page.

## Customization

You can create new table styles or modify any of the 25 predefined ones
by changing the dependency's `config/config.exs` file. You would then need to
run `mix deps.compile io_ansi_table [--force]` to make the changes effective.

## Current version

The current version supports:

  - multiple key headers
  - alternating row attributes
