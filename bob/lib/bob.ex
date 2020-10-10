defmodule Bob do
  def hey(input) do
    cond do
      yelled_question?(input) -> "Calm down, I know what I'm doing!"
      yelled_at?(input) -> "Whoa, chill out!"
      asked_question?(input) -> "Sure."
      nonsense_statement?(input) -> "Fine. Be that way!"
      true -> "Whatever."
    end
  end

  # Final character is a ?
  defp asked_question?(input) do
    String.match?(input, ~r/\?(\s+)?$/)
  end

  # All alpha characters made up of uppercase characters
  defp yelled_at?(input) do
    cond do
      String.match?(input, ~r/[[:lower:]]/x) -> false
      String.match?(input, ~r/[[:upper:]]/x) -> true
      String.match?(input, ~r/[0-9]|/) -> false
      true -> true
    end
  end

  # Final charcter is a ? AND is made up of uppercase charcters
  defp yelled_question?(input) do
    asked_question?(input) && yelled_at?(input)
  end

  # ends in a control character, whitespace, or has no content at all
  defp nonsense_statement?(input) do
    String.match?(input, ~r/^[[:cntrl:][:blank:]]+$|^(?![\s\S])/)
  end
end
