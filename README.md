# IO ANSI Table

[![Build Status](https://travis-ci.org/RaymondLoranger/io_ansi_table.svg?branch=master)](https://travis-ci.org/RaymondLoranger/io_ansi_table)

Writes data to stdout in a table with borders and colors.
Can choose a table style to change the look of the table.

##### Inspired by the book [Programming Elixir](https://pragprog.com/book/elixir16/programming-elixir-1-6) by Dave Thomas.

## Installation

Add `io_ansi_table` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:io_ansi_table, "~> 1.0"}
  ]
end
```

You may _also_ define `io_ansi_table` as an included application, if only using
the [IO.ANSI.Table.write/3][write/3] function:

```elixir
def application do
  [
    included_applications: [:io_ansi_table],
    extra_applications: [:logger]
  ]
end
```

## Examples

```elixir
alias IO.ANSI.Table

people = [
  %{name: "Mike", likes: "ski, arts", dob: "1992-04-15", bmi: 23.9},
  %{name: "Mary", likes: "travels"  , dob: "1992-04-15", bmi: 26.8},
  %{name: "Ann" , likes: "reading"  , dob: "1992-04-15", bmi: 24.7},
  %{name: "Ray" , likes: "cycling"  , dob: "1977-08-28", bmi: 19.1},
  %{name: "Bill", likes: "karate"   , dob: "1977-08-28", bmi: 18.1},
  %{name: "Joe" , likes: "boxing"   , dob: "1977-08-28", bmi: 20.8},
  %{name: "Jill", likes: "cooking"  , dob: "1976-09-28", bmi: 25.8}
]

Table.start([:name, :dob, :likes],
  header_fixes: %{~r[dob]i => "Date of Birth"},
  sort_specs: [asc: :dob],
  align_specs: [center: :dob],
  margins: [top: 2, bottom: 2, left: 2]
)

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

For side-by-side tables, you can specify a negative top margin.

In addition to the 16 standard ANSI colors<sup>[1](#footnote1)</sup> and their
background counterparts, this package also supports the 256 Xterm colors (foreground and background).

Most of these 256 colors were given names like:
- <img src="images/00ffff.png"> `:aqua`
- <img src="images/87ff00.png"> `:chartreuse`
- <img src="images/d700ff.png"> `:psychedelic_purple`

For details, see file `config/persist_colors.exs` of dependency
[io_ansi_plus][io_ansi_plus].

The following 2 packages use `io_ansi_table` as a dependency to tabulate
data fetched from the web:

  - [Github Issues][github_issues]
  - [NOAA Observations][noaa_observations]

Invocation from a remote shell is now supported (courtesy of [milkwine][mw]).

Sorting on [Date][Date] columns or other struct types like [Version][Version]
is now supported.

<sup><a name="footnote1">1</a></sup> Actually 8 colors and their "bright" variants.

## Latest version

The latest version supports:

  - sorting on multiple columns
  - alternating row attributes
  - alignment of column elements
  - sort direction indicators
  - negative top margin
  - ANSI and Xterm colors
  - invocation from remote shell
  - sorting on [Date][Date] columns

  [io_ansi_plus]: https://github.com/RaymondLoranger/io_ansi_plus
  [Date]: https://hexdocs.pm/elixir/Date.html
  [Version]: https://hexdocs.pm/elixir/Version.html
  [mw]: https://github.com/milkwine
  [github_issues]: https://hex.pm/packages/github_issues
  [noaa_observations]: https://hex.pm/packages/noaa_observations
  [write/3]: https://hexdocs.pm/io_ansi_table/IO.ANSI.Table.html#write/3
