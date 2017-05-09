
defmodule IO.ANSI.Table.Formatter.HelperTest do
  @moduledoc false

  use ExUnit.Case, async: true

  alias IO.ANSI.Table.Formatter.Helper

  doctest Helper

  setup_all do
    elements = ["Number", "Created At", "Title"]
    delimiters = {"{", "│", "}"}
    {:ok, elements: elements, delimiters: delimiters}
  end

  describe "IO.ANSI.Table.Formatter.Helper.expand/2" do
    test "expands elements correctly",
      %{elements: elements, delimiters: delimiters}
    do
      assert Helper.expand(elements, delimiters)
      == ["{", "Number", "│", "Created At", "│", "Title", "}"]
    end
  end
end
