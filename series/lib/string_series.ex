defmodule StringSeries do
  @doc """
  Given a string `string` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `string`, or less than 1,
  return an empty list.
  """
  @spec slices(string :: String.t(), size :: integer) :: list(String.t())
  def slices(string, size) do
    inside_loop(string, size)
    |> List.flatten()
  end

  defp inside_loop(string, size) do
    string_length = String.length(string)

    cond do
      size > string_length or size <= 0 ->
        []

      size <= string_length ->
        {first_slice, _remaining_string} = String.split_at(string, size)
        [first_slice, inside_loop(String.slice(string, 1..-1), size)]
    end
  end
end

# Take (string), given (size), return string of given size from given string
# = first_slice
# Send the string minus the first character to do it all over again
# StringSeries.slices("01234", 1)
