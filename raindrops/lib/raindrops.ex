defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t()
  def convert(number) do
    new_string =
      ""
      |> does_it_factor(number, 3, "Pling")
      |> does_it_factor(number, 5, "Plang")
      |> does_it_factor(number, 7, "Plong")

    if new_string == "" do
      Integer.to_string(number)
    else
      new_string
    end
  end

  defp does_it_factor(input_string, number, divisor, adding_string) do
    if rem(number, divisor) == 0 do
      input_string <> adding_string
    else
      input_string
    end
  end
end
