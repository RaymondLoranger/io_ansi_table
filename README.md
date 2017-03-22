# IO.ANSI.Table

Prints data to STDOUT in a table with borders and colors.
Can choose a table style among the 16 already predefined.

## Using

To use IO.ANSI.Table in your Mix projects, first add it as a dependency:

```elixir
def deps do
  [{:io_ansi_table, "~> 0.1", app: false}]
end
```

After adding IO.ANSI.TABLE as a dependency, run mix deps.get to install it.

Then in your config/config.exs configure table headers and a key header.
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

## Examples

```elixir
alias IO.ANSI.Table.Formatter
people = [
  %{name: "Mike", likes: "ski, arts", date_of_birth: "1992-04-15"},
  %{name: "Mary", likes: "reading"  , date_of_birth: "1985-07-11"},
  %{name: "Ray" , likes: "cycling"  , date_of_birth: "1977-08-28"}
]
Formatter.print_table(
  people, 3, true, :dark,
  headers: [:name, :date_of_birth, :likes],
  key_header: :date_of_birth
)
```
## ![print_table_people](images/print_table_people.png)