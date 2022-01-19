defmodule IO.ANSI.Table.Spec.LeftMargin do
  @moduledoc """
  Derives the left margin of a table.
  """

  alias IO.ANSI.Plus, as: ANSI
  alias IO.ANSI.Table.Spec

  @spec derive_and_put(Spec.t()) :: Spec.t()
  def derive_and_put(%Spec{margins: margins} = spec) do
    left_margin =
      case margins[:left] do
        # Move the cursor forward N columns: \e[<N>C
        n when n >= 1 -> ANSI.cursor_right(n)
        _ -> ""
      end

    put_in(spec.left_margin, left_margin)
  end
end
