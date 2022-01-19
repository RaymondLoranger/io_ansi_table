defmodule IO.ANSI.Table.Spec.AlignAttrs do
  @moduledoc """
  Derives the alignment attributes of a table.
  """

  alias IO.ANSI.Table.{Header, Spec}

  @spec derive_and_put(Spec.t()) :: Spec.t()
  def derive_and_put(
        %Spec{
          headers: headers,
          align_specs: align_specs
        } = spec
      ) do
    attrs = Enum.map(headers, &Header.find_attr(&1, align_specs, :left))
    put_in(spec.align_attrs, attrs)
  end
end
