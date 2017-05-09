
defmodule IO.ANSI.Table.FormatterTest do
  @moduledoc false

  use ExUnit.Case, async: true

  alias ExUnit.CaptureIO, as: CIO # allows to capture stuff sent to STDOUT
  alias IO.ANSI.Table.Formatter, as: TF

  doctest TF

  setup_all do
    fake_maps = Enum.map ~w/c z b a y x/, &%{key: &1, other: &1}
    maps = [ # unordered maps with atom keys and string values...
      %{c1: "r3 c1", c2: "r3 c2" , c3: "r3 c3", c4: "r3 c4"  },
      %{c1: "r1 c1", c2: "r1 c2" , c3: "r1 c3", c4: "r1+++c4"},
      %{c1: "r4 c1", c2: "r4++c2", c3: "r4 c3", c4: "r4 c4"  },
      %{c1: "r2 c1", c2: "r2 c2" , c3: "r2 c3", c4: "r2 c4"  }
    ]
    {:ok, fake_maps: fake_maps, maps: maps}
  end

  describe "IO.ANSI.Table.Formatter.key_for/2" do
    test "fake maps sorted on :key", %{fake_maps: fake_maps} do
      assert fake_maps
      |> Enum.sort_by(&TF.key_for &1, [:key])
      |> Enum.map(& &1.key)
      == ~w/a b c x y z/
    end
  end

  describe "IO.ANSI.Table.Formatter.print_table/5" do
    test "formats table ok", %{maps: maps} do
      result = CIO.capture_io fn ->
        TF.print_table(
          maps, 4, false, :test,
          headers: [:c4, :c1, :c2],
          key_headers: [:c4],
          margins: [top: 0, bottom: 0, left: 0]
        )
      end
      assert result == """
      ┌─────────┬───────┬────────┐
      │ C4      │ C1    │ C2     │
      ├─────────┼───────┼────────┤
      │ r1+++c4 │ r1 c1 │ r1 c2  │
      │ r2 c4   │ r2 c1 │ r2 c2  │
      │ r3 c4   │ r3 c1 │ r3 c2  │
      │ r4 c4   │ r4 c1 │ r4++c2 │
      └─────────┴───────┴────────┘
      """
    end

    test "positions table ok", %{maps: maps} do
      result = CIO.capture_io fn ->
        TF.print_table(
          maps, 4, false, :test,
          headers: [:c4, :c1, :c2],
          key_headers: [:c4],
          margins: [top: 1, bottom: 1, left: 6]
        )
      end
      assert result == """

            ┌─────────┬───────┬────────┐
            │ C4      │ C1    │ C2     │
            ├─────────┼───────┼────────┤
            │ r1+++c4 │ r1 c1 │ r1 c2  │
            │ r2 c4   │ r2 c1 │ r2 c2  │
            │ r3 c4   │ r3 c1 │ r3 c2  │
            │ r4 c4   │ r4 c1 │ r4++c2 │
            └─────────┴───────┴────────┘

      """
    end
  end

  describe "IO.ANSI.Table.Formatter.colums/2" do
    test "returns list of columns", %{maps: maps} do
      columns = TF.columns maps, [:c4, :c1, :c2]
      assert length(columns) == 3
      assert List.first(columns) == ["r3 c4", "r1+++c4", "r4 c4", "r2 c4"]
      assert List.last(columns) == ["r3 c2", "r1 c2", "r4++c2", "r2 c2"]
    end
  end

  describe "IO.ANSI.Table.Formatter.rows/2" do
    test "returns list of rows", %{maps: maps} do
      rows = TF.rows maps, [:c4, :c1, :c2]
      assert length(rows) == length(maps)
      assert List.first(rows) == ["r3 c4", "r3 c1", "r3 c2"]
      assert List.last(rows) == ["r2 c4", "r2 c1", "r2 c2"]
    end
  end

  describe "IO.ANSI.Table.Formatter.column_widths/1" do
    test "returns max column widths", %{maps: maps} do
      assert TF.columns(maps, [:c4, :c1, :c2]) |> TF.column_widths == [7, 5, 6]
    end
  end
end
