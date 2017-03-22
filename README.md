# IO ANSI Table

Prints data to STDOUT in a table with borders and colors.
Can choose a table style among the 16 already predefined.

## Using

To use `IO ANSI Table` in your Mix projects, first add it as a dependency:

```elixir
def deps do
  [{:io_ansi_table, "~> 0.1", app: false}]
end
```

After adding `IO ANSI Table` as a dependency, run mix deps.get to install it.

Then in your config/config.exs file, configure table headers and a key header.

Here is an example, if your table relates to Github Issues:

```elixir
config :io_ansi_table, headers: [
  "number", "created_at", "updated_at", "id", "title"
]
config :io_ansi_table, key_header: "created_at"
```

You can also position the table by specifying up to 3 margins:

```elixir
config :io_ansi_table, margins: [
  top:    1, # line(s) before table
  bottom: 1, # line(s) after table
  left:   2  # space(s) left of table
]
```

Otherwise all 3 margins will default to 0.

## Example

```elixir
config :io_ansi_table, headers: [:name, :date_of_birth, :likes]
config :io_ansi_table, key_header: :date_of_birth
config :io_ansi_table, margins: [
  top:    2, # line(s) before table
  bottom: 2, # line(s) after table
  left:   2  # space(s) left of table
]
```

```elixir
alias IO ANSI Table.Formatter
people = [
  %{name: "Mike", likes: "ski, arts", date_of_birth: "1992-04-15"},
  %{name: "Mary", likes: "reading"  , date_of_birth: "1985-07-11"},
  %{name: "Ray" , likes: "cycling"  , date_of_birth: "1977-08-28"}
]
Formatter.print_table(people, 3, true, :dark)
```
## ![print_table_people](images/print_table_people.png)

## Customization

You can create new table styles or modify any of the 16 predifined ones
by changing the dependency's config/config.exs file. You would then need
to run mix deps.compile io_ansi_table [--force] to make them effective.

## Future versions

Future versions may support:

  - multiple header keys
  - alternating line attributes
