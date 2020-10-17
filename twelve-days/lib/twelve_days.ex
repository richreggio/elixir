defmodule TwelveDays do
  @doc """
  Given a `number`, return the song's verse for that specific day, including
  all gifts for previous days in the same line.
  """
  @spec verse(number :: integer) :: String.t()
  def verse(number) do
    "On the #{day(number)} day of Christmas my true love gave to me:#{presents(number)}"
  end

  @doc """
  Given a `starting_verse` and an `ending_verse`, return the verses for each
  included day, one per line.
  """
  @spec verses(starting_verse :: integer, ending_verse :: integer) :: String.t()
  def verses(starting_verse, ending_verse) do
    Range.new(starting_verse, ending_verse)
    |> Enum.map_join("\n", &verse(&1))
  end

  @doc """
  Sing all 12 verses, in order, one verse per line.
  """
  @spec sing() :: String.t()
  def sing do
    verses(1, 12)
  end

  defp presents(number) when number != 1 do
    verse_string(number) <> presents(number - 1)
  end

  defp presents(number) when number == 1 do
    verse_string(number)
  end

  defp day(1), do: "first"
  defp day(2), do: "second"
  defp day(3), do: "third"
  defp day(4), do: "fourth"
  defp day(5), do: "fifth"
  defp day(6), do: "sixth"
  defp day(7), do: "seventh"
  defp day(8), do: "eighth"
  defp day(9), do: "ninth"
  defp day(10), do: "tenth"
  defp day(11), do: "eleventh"
  defp day(12), do: "twelfth"

  defp verse_string(1), do: " a Partridge in a Pear Tree."
  defp verse_string(2), do: " two Turtle Doves, and"
  defp verse_string(3), do: " three French Hens,"
  defp verse_string(4), do: " four Calling Birds,"
  defp verse_string(5), do: " five Gold Rings,"
  defp verse_string(6), do: " six Geese-a-Laying,"
  defp verse_string(7), do: " seven Swans-a-Swimming,"
  defp verse_string(8), do: " eight Maids-a-Milking,"
  defp verse_string(9), do: " nine Ladies Dancing,"
  defp verse_string(10), do: " ten Lords-a-Leaping,"
  defp verse_string(11), do: " eleven Pipers Piping,"
  defp verse_string(12), do: " twelve Drummers Drumming,"
end
