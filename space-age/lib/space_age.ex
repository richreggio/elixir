defmodule SpaceAge do
  @type planet ::
          :mercury
          | :venus
          | :earth
          | :mars
          | :jupiter
          | :saturn
          | :uranus
          | :neptune

  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet'.
  """
  @spec age_on(planet, pos_integer) :: float
  def age_on(planet, seconds) do
    seconds / year_in_seconds(planet)
  end

  defp year_in_seconds(:mercury), do: 31_557_600 * 0.2408467
  defp year_in_seconds(:venus), do: 31_557_600 * 0.61519726
  defp year_in_seconds(:earth), do: 31_557_600
  defp year_in_seconds(:mars), do: 31_557_600 * 1.8808158
  defp year_in_seconds(:jupiter), do: 31_557_600 * 11.862615
  defp year_in_seconds(:saturn), do: 31_557_600 * 29.447498
  defp year_in_seconds(:uranus), do: 31_557_600 * 84.016846
  defp year_in_seconds(:neptune), do: 31_557_600 * 164.79132
end
