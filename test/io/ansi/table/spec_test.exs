defmodule IO.ANSI.Table.SpecTest do
  use ExUnit.Case, async: true

  # Allows to capture IO...
  alias ExUnit.CaptureIO
  alias IO.ANSI.Table.Spec

  doctest Spec

  setup_all do
    maps = [
      # Unordered maps with atom keys and string values...
      %{c1: "r3 c1", c2: "r3 c2" , c3: "r3 c3", c4: "r3 c4"  },
      %{c1: "r1 c1", c2: "r1 c2" , c3: "r1 c3", c4: "r1+++c4"},
      %{c1: "r4 c1", c2: "r4++c2", c3: "r4 c3", c4: "r4 c4"  },
      %{c1: "r2 c1", c2: "r2 c2" , c3: "r2 c3", c4: "r2 c4"  }
    ]

    headers = [:c4, :c1, :c2]

    options_000 = [
      margins: [top: 0, bottom: 0, left: 0],
      sort_specs: [:c4],
      style: :test
    ]

    options_102 = [
      margins: [top: 1, bottom: 0, left: 2],
      sort_specs: [:c4],
      sort_symbols: [asc: "⬆", pos: :leading],
      style: :test
    ]

    bad_margins_101 = [
      margins: [before: 1, after: 0, left: 1],
      sort_specs: [:c4],
      sort_symbols: [asc: "⬆", pos: [:leading, :trailing]],
      style: :test
    ]

    spec_000 = Spec.new(headers, options_000) |> Spec.develop()
    spec_102 = Spec.new(headers, options_102) |> Spec.develop()
    bad_margins_101 = Spec.new(headers, bad_margins_101) |> Spec.develop()

    %{
      spec_000: spec_000,
      spec_102: spec_102,
      bad_margins_101: bad_margins_101,
      maps: maps
    }
  end

  describe "Spec.write_table/2" do
    test "formats table ok", %{spec_000: spec, maps: maps} do
      capture =
        fn -> Spec.write_table(spec, maps) end
        |> CaptureIO.capture_io()

      output = """
      ┌─────────┬───────┬────────┐
      │ C4↑     │ C1    │ C2     │
      ├─────────┼───────┼────────┤
      │ r1+++c4 │ r1 c1 │ r1 c2  │
      │ r2 c4   │ r2 c1 │ r2 c2  │
      │ r3 c4   │ r3 c1 │ r3 c2  │
      │ r4 c4   │ r4 c1 │ r4++c2 │
      └─────────┴───────┴────────┘
      """

      assert capture == output
    end

    test "positions table ok", %{spec_102: spec, maps: maps} do
      capture =
        fn -> Spec.write_table(spec, maps) end
        |> CaptureIO.capture_io()
        |> String.replace(spec.left_margin, "  ")

      output = """

        ┌─────────┬───────┬────────┐
        │ ⬆C4     │ C1    │ C2     │
        ├─────────┼───────┼────────┤
        │ r1+++c4 │ r1 c1 │ r1 c2  │
        │ r2 c4   │ r2 c1 │ r2 c2  │
        │ r3 c4   │ r3 c1 │ r3 c2  │
        │ r4 c4   │ r4 c1 │ r4++c2 │
        └─────────┴───────┴────────┘
      """

      assert capture == output and spec.left_margin == "\e[2C"
    end

    test "bad margins ignored", %{bad_margins_101: spec, maps: maps} do
      capture =
        fn -> Spec.write_table(spec, maps) end
        |> CaptureIO.capture_io()
        |> String.replace(spec.left_margin, " ")

      output = """

       ┌─────────┬───────┬────────┐
       │ ⬆C4⬆    │ C1    │ C2     │
       ├─────────┼───────┼────────┤
       │ r1+++c4 │ r1 c1 │ r1 c2  │
       │ r2 c4   │ r2 c1 │ r2 c2  │
       │ r3 c4   │ r3 c1 │ r3 c2  │
       │ r4 c4   │ r4 c1 │ r4++c2 │
       └─────────┴───────┴────────┘

      """

      assert capture == output and spec.left_margin == "\e[1C"
    end
  end
end
