defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    String.split(text, "", trim: true)
    |> Enum.map(fn single_char_string -> shift_letter(single_char_string, shift) end)
    |> Enum.join()
  end

  defp shift_letter(<<single_char_value>>, shift) when shift in 0..26 do
    cond do
      single_char_value in 65..90 -> rollover_check(single_char_value, shift)
      single_char_value in 97..122 -> rollover_check(single_char_value, shift)
      true -> <<single_char_value>>
    end
  end

  defp rollover_check(single_char_value, shift) when single_char_value in 65..90 do
    cond do
      single_char_value + shift > 90 -> <<single_char_value - 26 + shift>>
      true -> <<single_char_value + shift>>
    end
  end

  defp rollover_check(single_char_value, shift) when single_char_value in 97..122 do
    cond do
      single_char_value + shift > 122 -> <<single_char_value - 26 + shift>>
      true -> <<single_char_value + shift>>
    end
  end
end
