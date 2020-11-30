defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """

  def compare(a, a), do: :equal
  def compare([], _), do: :sublist
  def compare(_, []), do: :superlist

  def compare(a, b) do
    cond do
      contains?(a, b) ->
        :sublist

      contains?(b, a) ->
        :superlist

      true ->
        :unequal
    end
  end

  defp contains?(a, b) when length(a) > length(b), do: false

  defp contains?(a, b) do
    Stream.chunk_every(b, length(a), 1, :discard)
    |> Enum.any?(&(&1 === a))
  end
end
