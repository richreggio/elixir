defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    Enum.map(factors, &factor_range(limit, &1))
    |> List.flatten()
    |> Enum.uniq()
    |> Enum.sum()
  end

  defp factor_range(limit, factor) do
    cond do
      rem(limit, factor) == 0 ->
        0..(div(limit, factor) - 1)
        |> Enum.map(&(&1 * factor))

      true ->
        0..div(limit, factor)
        |> Enum.map(&(&1 * factor))
    end
  end
end
