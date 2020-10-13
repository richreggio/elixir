defmodule SecretHandshake do
  use Bitwise

  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    {code, []}
    |> bit_check("wink")
    |> bit_check("double blink")
    |> bit_check("close your eyes")
    |> bit_check("jump")
    |> bit_check("reverse list")
    |> elem(1)
  end

  defp bit_check({number, command_list}, "reverse list") when band(number, 1) == 1 do
    new_list = Enum.reverse(command_list)
    {number, new_list}
  end

  defp bit_check({number, command_list}, command) when band(number, 1) == 1 do
    new_list = command_list ++ List.wrap(command)
    new_number = number >>> 1
    {new_number, new_list}
  end

  defp bit_check({number, command_list}, _command) when band(number, 1) == 0 do
    new_list = command_list
    new_number = number >>> 1
    {new_number, new_list}
  end
end

# Needs to take in an int and checks each of the first 5 bits and either adds the given string
# to a list or in the case of the fifth bit reverses the order of the list (Enum.reverse())
