defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    String.split(string, ~r/[[:space:]]|[-_]/, trim: true)
    |> Enum.map(&multi_case_check(&1))
    |> List.flatten()
    |> Enum.map(&String.first(&1))
    |> Enum.join()
    |> String.upcase()
  end

  defp multi_case_check(string) do
    Regex.split(~r/([A-Z]|[a-z])[a-z]+('s)?[[:punct:]]{0,}/, string,
      include_captures: true,
      trim: true
    )
  end
end
