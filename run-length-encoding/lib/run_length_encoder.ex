defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) do
    # Search the string for any repeating characters or spaces
    Regex.scan(~r/([[:alpha:]]|[[:blank:]])\1+/, string)
    # If there are any matches they are sent to be 'compressed'
    |> Enum.map(fn list ->
      # Each list has 2 values, the full match (raw_value) and the matching character (letter_value)
      [raw_value, letter_value] = list

      encoded_value =
        raw_value
        # Turns the full match into a number based on its length (# of repeated characters or spaces)
        |> String.length()
        # In turn it is changed back into a string
        |> Integer.to_string()

      # Appends the number string to the matching character
      [encoded_value <> letter_value]
    end)
    |> List.flatten()
    # Finds and replaces each unencoded section with its encoded version
    |> encoding_loop(string)
  end

  @spec decode(String.t()) :: String.t()
  def decode(string) do
    # Search the string for any number (ALL numbers mean encoded values in our case)
    Regex.scan(~r/[0-9]+./, string)
    # If there are any matches they are sent to 'uncompressed'
    |> Enum.map(fn list ->
      # Each list is a wrapper for a string that is always a number followed by a single character
      [encoded_string] = list

      encoded_string
      # Splits the string between the number and character parts
      |> String.split_at(-1)
      # Iterates over the character (number) of times to give the decoded string
      |> letter_loop()
    end)
    |> List.flatten()
    # Finds and replaces each encoded section with its unencoded version
    |> decoding_loop(string)
  end

  # Encoding

  defp encoding_loop([], string) do
    string
  end

  defp encoding_loop([head | tail] = _encoded_string, string) do
    new_string = String.replace(string, ~r/([[:alpha:]]|[[:blank:]])\1+/, head, global: false)
    encoding_loop(tail, new_string)
  end

  # Decoding

  defp decoding_loop([], string) do
    string
  end

  defp decoding_loop([head | tail] = _decoded_string, string) do
    new_string = String.replace(string, ~r/[0-9]+./, head, global: false)
    decoding_loop(tail, new_string)
  end

  defp letter_loop({number_string, letter_string}) do
    count = String.to_integer(number_string)
    letter_loop(count, letter_string)
  end

  defp letter_loop(count, string) when count != 0 do
    letter_loop(count - 1, string, string)
  end

  defp letter_loop(count, built_string, string) when count != 0 do
    letter_loop(count - 1, string <> built_string, string)
  end

  defp letter_loop(count, built_string, _string) when count == 0 do
    built_string
  end
end
