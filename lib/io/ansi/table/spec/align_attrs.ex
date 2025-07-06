defmodule IO.ANSI.Table.Spec.AlignAttrs do
  @moduledoc """
  Derives the align attributes of a table.
  """

  alias IO.ANSI.Table.{Header, Spec}

  @doc """
  Derives the align attributes of a table.

  ## Examples

      iex> alias IO.ANSI.Table.Spec.AlignAttrs
      iex> alias IO.ANSI.Table.Spec
      iex> spec = Spec.new([:c4, :c1, :c2], align_specs: [right: :c2])
      iex> %Spec{align_attrs: align_attrs} = AlignAttrs.derive_and_put(spec)
      iex> align_attrs
      [nil, nil, :right]
  """
  @spec derive_and_put(Spec.t()) :: Spec.t()
  def derive_and_put(%Spec{headers: headers, align_specs: specs} = spec) do
    attrs = Enum.map(headers, &Header.find_attr(&1, specs, :left))
    put_in(spec.align_attrs, attrs)
  end
end
