defmodule Scrabble do
  %{A => 1}

  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t()) :: non_neg_integer
  def score(""), do: 0

  def score(word) do
    String.upcase(word)
    |> String.codepoints()
    |> Enum.map(&points(&1))
    |> Enum.reduce(&(&1 + &2))
  end

  defp points(codepoint) do
    cond do
      String.contains?(codepoint, ["A", "E", "I", "O", "U", "L", "N", "R", "S", "T"]) ->
        1

      String.contains?(codepoint, ["D", "G"]) ->
        2

      String.contains?(codepoint, ["B", "C", "M", "P"]) ->
        3

      String.contains?(codepoint, ["F", "H", "V", "W", "Y"]) ->
        4

      String.contains?(codepoint, "K") ->
        5

      String.contains?(codepoint, ["J", "X"]) ->
        8

      String.contains?(codepoint, ["Q", "Z"]) ->
        10

      true ->
        0
    end
  end
end
