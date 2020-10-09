defmodule RnaTranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RnaTranscription.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) when is_list(dna) do
    for char <- dna do char_converter(char) end
  end

  defp char_converter(?G) do
    ?C
  end
  defp char_converter(?C) do
    ?G
  end
  defp char_converter(?T) do
    ?A
  end
  defp char_converter(?A) do
    ?U
  end
end
