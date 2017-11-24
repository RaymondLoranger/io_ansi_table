defmodule IO.ANSI.Table.StyleTest do
  @moduledoc false

  use ExUnit.Case, async: true

  alias IO.ANSI.Table.Style

  doctest Style

  describe "Style.from_switch_arg/1" do
    test "converts a switch arg to a table style" do
      assert Style.from_switch_arg("light"    ) == {:ok, :light}
      assert Style.from_switch_arg("green-alt") == {:ok, :green_alt}
      assert Style.from_switch_arg("Light"    ) == :error
    end
  end

  describe "Style.to_switch_arg/1" do
    test "converts a table style to a switch arg" do
      assert Style.to_switch_arg(:light    ) == "light"
      assert Style.to_switch_arg(:green_alt) == "green-alt"
      assert Style.to_switch_arg(:Light    ) == nil
    end
  end

  describe "Style.line_types/1" do
    test "returns the line types of a table style" do
      expected1 = [:top, :header, :separator, [:row], :bottom]
      expected2 = [:top, :header, :separator, [:row_1, :row_2, :row_3]]
      assert Style.line_types(:pretty    ) == expected1
      assert Style.line_types(:green_mult) == expected2
    end
  end

  describe "Style.dash/2" do
    test "returns the dash of a table style and line type" do
      assert Style.dash(:dark , :separator) == "═"
      assert Style.dash(:light, :bottom   ) == "─"
      assert Style.dash(:heavy, :bottom   ) == nil
    end
  end

  describe "Style.borders/2" do
    test "returns the borders of a table style and line type" do
      assert Style.borders(:light , :bottom   ) == ["└─", "─┴─", "─┘"]
      assert Style.borders(:medium, :separator) == ["╟─", "─┼─", "─╢"]
      assert Style.borders(:heavy , :bottom   ) == []
    end
  end

  describe "Style.border_spreads/2" do
    test "returns the border spreads of a table style and line type" do
      expected1 = [[0, 2, 0], [0, 3, 0], [0, 2, 0]]
      expected2 = [[0, 1, 1], [1, 1, 1], [1, 1, 0]]
      assert Style.border_spreads(:medium, :top) == expected1
      assert Style.border_spreads(:light , :row) == expected2
      assert Style.border_spreads(:heavy , :mid) == []
    end
  end

  describe "Style.border_attr/2" do
    test "returns the border attribute of a table style and line type" do
      expected = [:cyan, :cyan_background]
      assert Style.border_attr(:medium  , :bottom) == :light_yellow
      assert Style.border_attr(:cyan_alt, :top   ) == expected
      assert Style.border_attr(:heavy   , :top   ) == nil
    end
  end

  describe "Style.filler_attr/2" do
    test "returns the filler attribute of a table style and line type" do
      assert Style.filler_attr(:medium, :header) == :normal
      assert Style.filler_attr(:mixed , :row   ) == :light_green_background
      assert Style.filler_attr(:heavy , :bottom) == nil
    end
  end

  describe "Style.key_attr/2" do
    test "returns the key attribute of a table style and line type" do
      expected = [:light_blue, :light_cyan_background]
      assert Style.key_attr(:medium, :header) == [:light_green, :underline]
      assert Style.key_attr(:cyan  , :row   ) == expected
      assert Style.key_attr(:cyan  , :middle) == nil
    end
  end

  describe "Style.non_key_attr/2" do
    test "returns the non key attribute of a table style and line type" do
      expected = [:light_blue, :light_cyan_background]
      assert Style.non_key_attr(:medium, :header) == :light_green
      assert Style.non_key_attr(:cyan  , :bottom) == expected
      assert Style.non_key_attr(:cyan  , :middle) == nil
    end
  end

  describe "Style.texts/1" do
    test "returns a list of interpolated texts (one per table style)" do
      expected1 = "yellow-border         (light yellow border)"
      expected2 = "`:yellow_border`         - light yellow border"
      assert length(Style.texts "")                           == 35 # styles
      assert List.last(Style.texts "&arg&filler (&note)"    ) == expected1
      assert List.last(Style.texts "`&style`&filler - &note") == expected2
    end
  end
end
