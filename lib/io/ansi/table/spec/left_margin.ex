defmodule IO.ANSI.Table.Spec.LeftMargin do
  @moduledoc """
  Derives the left margin of a table.
  """

  alias IO.ANSI.Plus, as: ANSI
  alias IO.ANSI.Table.Spec

  @doc """
  Derives the left margin of a table.

  ## Examples

      iex> alias IO.ANSI.Table.Spec.LeftMargin
      iex> alias IO.ANSI.Table.Spec
      iex> spec = Spec.new([:c4, :c1, :c2], margins: [left: 3])
      iex> %Spec{left_margin: left_margin} = LeftMargin.derive_and_put(spec)
      iex> left_margin
      "\e[3C"

      iex> alias IO.ANSI.Table.Spec.LeftMargin
      iex> alias IO.ANSI.Table.Spec
      iex> spec = Spec.new([:c4, :c1, :c2], margins: [left: 0])
      iex> %Spec{left_margin: left_margin} = LeftMargin.derive_and_put(spec)
      iex> left_margin
      ""
  """
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
