exceptions = [
  "persist_defaults.exs",
  "persist_styles.exs",
  "ie.ex",
  "line.ex",
  "formatter_test.exs"
]

inputs = [
  ".formatter.exs",
  "mix.exs" | Path.wildcard("{config,lib,test}/**/*.{ex,exs}")
]

[
  inputs: Enum.reject(inputs, &(Path.basename(&1) in exceptions)),
  line_length: 80
]
