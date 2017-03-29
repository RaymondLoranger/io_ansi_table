
defmodule IO.ANSI.Table.StyleTest do
  @moduledoc false

  use ExUnit.Case, async: true

  alias IO.ANSI.Table.Style

  doctest Style

  test "Is it really that easy?" do
    assert Code.ensure_loaded?(Style)
  end

  describe "IO.ANSI.Table.Style.for/1" do
    test ~S/returns the table style for a table style "tag"/ do
      assert Style.style_for("light") == {:ok, :light}
      assert Style.style_for("Light") == :error
    end
  end

  describe "IO.ANSI.Table.Style.dash/2" do
    test "gets the dash of a table style and line/row type" do
      assert Style.dash(:dark , :separator) == "═"
      assert Style.dash(:light, :bottom   ) == "─"
      assert Style.dash(:heavy, :bottom   ) == nil
    end
  end

  describe "IO.ANSI.Table.Style.borders/2" do
    test "gets the borders of a table style and line/row type" do
      assert Style.borders(:medium, :separator) == {"╟─", "─┼─", "─╢"}
      assert Style.borders(:light , :bottom   ) == {"└─", "─┴─", "─┘"}
      assert Style.borders(:heavy , :bottom   ) == nil
    end
  end

  describe "IO.ANSI.Table.Style.border_widths/2" do
    test "gets the border widths of a table style and line/row type" do
      assert Style.border_widths(:medium, :top   )
      == {[2, 0], [0, 3, 0], [0, 2]}
      assert Style.border_widths(:light , :row   )
      == {[1, 1], [1, 1, 1], [1, 1]}
      assert Style.border_widths(:heavy , :bottom) == nil
    end
  end

  describe "IO.ANSI.Table.Style.border_attr/2" do
    test "gets the border attribute of a table style" do
      assert Style.border_attr(:medium, :bottom) == :light_yellow
      assert Style.border_attr(:light , :row   ) == :light_white
      assert Style.border_attr(:heavy , :top   ) == nil
    end
  end

  describe "IO.ANSI.Table.Style.filler_attr/2" do
    test "gets the filler attribute of a table style and line/row type" do
      assert Style.filler_attr(:medium, :header) == :normal
      assert Style.filler_attr(:mixed , :row   ) == :light_green_background
      assert Style.filler_attr(:heavy , :bottom) == nil
    end
  end

  describe "IO.ANSI.Table.Style.key_attr/2" do
    test "gets the key attribute of a table style and line/row type" do
      assert Style.key_attr(:medium, :header)
      == [:light_green, :underline]
      assert Style.key_attr(:cyan  , :row   )
      == [:light_blue, :light_cyan_background]
      assert Style.key_attr(:cyan  , :bottom)
      == [:light_blue, :light_cyan_background]
      assert Style.key_attr(:cyan  , :middle) == nil
    end
  end

  describe "IO.ANSI.Table.Style.non_key_attr/2" do
    test "gets the non key attribute of a table style and line/row type" do
      assert Style.non_key_attr(:medium, :header)
      == :light_green
      assert Style.non_key_attr(:cyan  , :row   )
      == [:black, :light_cyan_background]
      assert Style.non_key_attr(:cyan  , :bottom)
      == [:light_blue, :light_cyan_background]
      assert Style.non_key_attr(:cyan  , :middle) == nil
    end
  end

  describe "IO.ANSI.Table.Style.texts/1" do
    test "gets a list of interpolated texts (one per table style)" do
      assert length(Style.texts "?") == 25 # table styles
      assert List.last(Style.texts "  • &tag&filler (&note)")
      == "  • green-mult     (green header, 3 repeating row colors)"
      assert List.last(Style.texts "  - `&style`&filler - &note")
      == "  - `:green_mult`     - green header, 3 repeating row colors"
    end
  end
end
