defmodule RomanNumerals do
  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    number
    |> to_string()
    |> String.split("", trim: true)
    |> list_interpreter()
  end

  defp list_interpreter([thousand, hundred, ten, one]) do
    roman_thousand = thousand_converter(thousand)
    roman_hundred = hundred_converter(hundred)
    roman_ten = ten_converter(ten)
    roman_one = one_converter(one)

    roman_thousand <> roman_hundred <> roman_ten <> roman_one
  end

  defp list_interpreter([hundred, ten, one]) do
    roman_hundred = hundred_converter(hundred)
    roman_ten = ten_converter(ten)
    roman_one = one_converter(one)

    roman_hundred <> roman_ten <> roman_one
  end

  defp list_interpreter([ten, one]) do
    roman_ten = ten_converter(ten)
    roman_one = one_converter(one)

    roman_ten <> roman_one
  end

  defp list_interpreter([one]) do
    roman_one = one_converter(one)

    roman_one
  end

  defp thousand_converter("1"), do: "M"
  defp thousand_converter("2"), do: "MM"
  defp thousand_converter("3"), do: "MMM"

  defp hundred_converter("0"), do: ""
  defp hundred_converter("1"), do: "C"
  defp hundred_converter("2"), do: "CC"
  defp hundred_converter("3"), do: "CCC"
  defp hundred_converter("4"), do: "CD"
  defp hundred_converter("5"), do: "D"
  defp hundred_converter("6"), do: "DC"
  defp hundred_converter("7"), do: "DCC"
  defp hundred_converter("8"), do: "DCCC"
  defp hundred_converter("9"), do: "CM"

  defp ten_converter("0"), do: ""
  defp ten_converter("1"), do: "X"
  defp ten_converter("2"), do: "XX"
  defp ten_converter("3"), do: "XXX"
  defp ten_converter("4"), do: "XL"
  defp ten_converter("5"), do: "L"
  defp ten_converter("6"), do: "LX"
  defp ten_converter("7"), do: "LXX"
  defp ten_converter("8"), do: "LXXX"
  defp ten_converter("9"), do: "XC"

  defp one_converter("0"), do: ""
  defp one_converter("1"), do: "I"
  defp one_converter("2"), do: "II"
  defp one_converter("3"), do: "III"
  defp one_converter("4"), do: "IV"
  defp one_converter("5"), do: "V"
  defp one_converter("6"), do: "VI"
  defp one_converter("7"), do: "VII"
  defp one_converter("8"), do: "VIII"
  defp one_converter("9"), do: "IX"
end
