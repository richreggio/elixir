defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split()
    |> Enum.map(&parse_word(&1))
    |> Enum.join(" ")
  end

  defp parse_word(word) do
    cond do
      Regex.run(~r/^[aeiou]|^(x|y)[bcdfghjklmnpqrstvwxyz]/i, word) != nil ->
        "#{word}ay"

      Regex.run(~r/^(qu)|^[bcdfghjklmnpqrstvwxyz]+/i, word) != nil ->
        move_consonant(word) <> "ay"
    end
  end

  defp move_consonant(word) do
    Regex.split(~r/^(qu)|^[bcdfghjklmnprstvwxyz]+(qu)?|^[bcdfghjklmnpqrstvwxyz]+/i, word,
      include_captures: true,
      trim: true
    )
    |> Enum.reverse()
    |> List.to_string()
  end
end
