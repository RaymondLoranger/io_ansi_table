# Used by "mix format"
[
  inputs: ["*.exs", "{config,lib,test}/**/*.{ex,exs}"],
  excludes: [
    "config/persist_{defaults,ie_constants,styles}.exs",
    "lib/**/line.ex",
    "test/**/spec_test.exs"
  ],
  line_length: 80
]
