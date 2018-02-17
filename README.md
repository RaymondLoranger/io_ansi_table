# IO ANSI Table

Prints data to STDOUT in a table with borders and colors.
Can choose a table style to change the look of the table.

## Installation

Add the `:io_ansi_table` dependency to your `mix.exs` file:

```elixir
def deps() do
  [
    {:io_ansi_table, "~> 0.4"}
  ]
end
```

## Usage

In `config/config.exs`, you should then configure the table formatting
[options](https://hexdocs.pm/io_ansi_table/IO.ANSI.Table.Options.html).

## Examples

```elixir
config :io_ansi_table, headers: [:name, :dob, :likes]
config :io_ansi_table, header_fixes: %{~r[dob]i => "Date of Birth"}
config :io_ansi_table, sort_specs: [asc: :dob]
config :io_ansi_table, align_specs: [center: :dob]
config :io_ansi_table, margins: [top: 2, bottom: 2]
```

```elixir
alias IO.ANSI.Table
people = [
  %{name: "Mike", likes: "ski, arts", dob: ~D[1992-04-15], bmi: 23.9},
  %{name: "Mary", likes: "travels"  , dob: ~D[1992-04-15], bmi: 26.8},
  %{name: "Ann" , likes: "reading"  , dob: ~D[1992-04-15], bmi: 24.7},
  %{name: "Ray" , likes: "cycling"  , dob: ~D[1977-08-28], bmi: 19.1},
  %{name: "Bill", likes: "karate"   , dob: ~D[1977-08-28], bmi: 18.1},
  %{name: "Joe" , likes: "boxing"   , dob: ~D[1977-08-28], bmi: 20.8},
  %{name: "Jill", likes: "cooking"  , dob: ~D[1976-09-28], bmi: 25.8}
]
Table.format(people, style: :light)
Table.format(people, style: :light_alt)
Table.format(people, style: :light_mult)
Table.format(people, style: :cyan_alt)
Table.format(people, style: :cyan_mult)
```
## ![light](images/light.png)
## ![light_alt](images/light_alt.png)
## ![light_mult](images/light_mult.png)
## ![cyan_alt](images/cyan_alt.png)
## ![cyan_mult](images/cyan_mult.png)

## Notes

For side-by-side tables, you can specify negative top margins.

In addition to the basic ANSI foreground/background colors like
`yellow`, `light_red`, `green_background` or `light_blue_background`,
this package now supports all Xterm256 colors. Most of these 256 colors
were given names like `aqua`, `chartreuse` or `psychedelic_purple`.
For details, see the `config/persist_colors.exs` file.

The following 2 packages use `:io_ansi_table` as a dependency to tabulate
data fetched from the web:

  - [Github Issues](https://hex.pm/packages/github_issues)
  - [NOAA Observations](https://hex.pm/packages/noaa_observations)

## Customization

You can create new table styles or modify any predefined one by changing the
dependency's `config/persist_styles.exs` file. You would then need to run
`mix deps.compile io_ansi_table [--force]` to make the changes effective.

## Latest version

The latest version supports:

  - sorting on multiple headers
  - alternating row attributes
  - alignment of column elements
  - sort direction indicators
  - negative top margins
  - ANSI and Xterm256 colors
