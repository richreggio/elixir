defmodule BeerSong do
  @doc """
  Get a single verse of the beer song
  """
  @spec verse(integer) :: String.t()
  def verse(number) do
    verse_match(number)
  end

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """
  @spec lyrics(Range.t()) :: String.t()
  def lyrics(first..last \\ 99..0) do
    Range.new(first, last)
    |> lyrics_match()
  end

  defp verse_match(number) when number >= 3 do
    "#{number} bottles of beer on the wall, #{number} bottles of beer.\nTake one down and pass it around, #{
      number - 1
    } bottles of beer on the wall.\n"
  end

  defp verse_match(number) when number == 2 do
    "2 bottles of beer on the wall, 2 bottles of beer.\nTake one down and pass it around, 1 bottle of beer on the wall.\n"
  end

  defp verse_match(number) when number == 1 do
    "1 bottle of beer on the wall, 1 bottle of beer.\nTake it down and pass it around, no more bottles of beer on the wall.\n"
  end

  defp verse_match(number) when number == 0 do
    "No more bottles of beer on the wall, no more bottles of beer.\nGo to the store and buy some more, 99 bottles of beer on the wall.\n"
  end

  defp lyrics_match(first..last) do
    cond do
      first > last ->
        verse_match(first) <> "\n" <> lyrics_match((first - 1)..last)

      first == last ->
        verse_match(last)
    end
  end
end
