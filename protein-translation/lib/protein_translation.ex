defmodule ProteinTranslation do
  @codons %{
    UGU: "Cysteine",
    UGC: "Cysteine",
    UUA: "Leucine",
    UUG: "Leucine",
    AUG: "Methionine",
    UUU: "Phenylalanine",
    UUC: "Phenylalanine",
    UCU: "Serine",
    UCC: "Serine",
    UCA: "Serine",
    UCG: "Serine",
    UGG: "Tryptophan",
    UAU: "Tyrosine",
    UAC: "Tyrosine",
    UAA: "STOP",
    UAG: "STOP",
    UGA: "STOP"
  }
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(rna) do
    cond do
      valid_rna?(rna) -> {:ok, split_rna(rna)}
      true -> {:error, "invalid RNA"}
    end
  end

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon(codon) do
    cond do
      valid_rna?(codon) -> {:ok, decode_codon(codon)}
      true -> {:error, "invalid codon"}
    end
  end

  # Checks if the given string consists only of the characters "UCGA"
  defp valid_rna?(string) do
    Regex.run(~r/^[UCGA]+$/, string) != nil
  end

  # Takes a given valid string of RNA and cuts it into a list of 3 letter codons
  defp split_rna(rna_string) do
    rna_string
    |> Stream.unfold(&String.split_at(&1, 3))
    |> Enum.take_while(&(&1 != ""))
    |> decode_codon_list()
  end

  # Takes a given list of codons and return proteins until finished or reaching a STOP codon
  defp decode_codon_list(codon_list) do
    codon_list
    |> Stream.map(&decode_codon(&1))
    |> Enum.take_while(&(&1 != "STOP"))
  end

  # Takes a given codon and returns it's corresponding protein
  defp decode_codon(codon) when is_binary(codon) and byte_size(codon) == 3 do
    atomized_codon = String.to_atom(codon)
    Map.fetch!(@codons, atomized_codon)
  end
end
