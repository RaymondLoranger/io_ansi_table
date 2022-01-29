defmodule IO.ANSI.Table.Spec.SortAttrs do
  @moduledoc """
  Derives the sort attributes of a table.
  """

  alias IO.ANSI.Table.{Header, Spec}

  @doc """
  Derives the sort attributes of a table.
  
  ## Examples
  
      iex> alias IO.ANSI.Table.Spec.SortAttrs
      iex> alias IO.ANSI.Table.Spec
      iex> spec = Spec.new([:c4, :c1, :c2], sort_specs: [desc: :c2])
      iex> %Spec{sort_attrs: sort_attrs} = SortAttrs.derive_and_put(spec)
      iex> sort_attrs
      [nil, nil, :desc]
  """
  @spec derive_and_put(Spec.t()) :: Spec.t()
  def derive_and_put(%Spec{headers: headers, sort_specs: sort_specs} = spec) do
    attrs = Enum.map(headers, &Header.find_attr(&1, sort_specs, :asc))
    put_in(spec.sort_attrs, attrs)
  end
end
