# Used by "mix format"
wildcard = fn glob -> Path.wildcard(glob, match_dot: true) end
matches = fn globs -> Enum.flat_map(globs, &wildcard.(&1)) end

except = [
  "config/persist_{defaults,styles,ie_constants}.exs",
  "lib/**/line.ex",
  "test/**/spec_test.exs"
]

inputs = ["*.exs", "{config,lib,test}/**/*.{ex,exs}"]

[
  inputs: matches.(inputs) -- matches.(except),
  line_length: 80
]
