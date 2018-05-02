wildcard = fn glob -> Path.wildcard(glob, match_dot: true) end
matches = fn globs -> Enum.flat_map(globs, &wildcard.(&1)) end

except = [
  "config/persist_{defaults,styles}.exs",
  "lib/**/{ie,line}.ex",
  "test/**/formatter_test.exs"
]

inputs = ["*.exs", "{config,lib,test}/**/*.{ex,exs}"]

[
  inputs: matches.(inputs) -- matches.(except),
  line_length: 80
]
