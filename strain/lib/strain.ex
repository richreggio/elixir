defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def keep(list, fun) when list != [] do
    list
    |> Enum.map(fun)
    |> Enum.zip(list)
    |> check_for_boolean(true)
  end

  def keep(list, _fun) when list == [], do: []

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def discard(list, fun) when list != [] do
    list
    |> Enum.map(fun)
    |> Enum.zip(list)
    |> check_for_boolean(false)
  end

  def discard(list, _fun) when list == [], do: []

  defp check_for_boolean(list, keep_or_discard) do
    list
    |> Enum.split_with(fn {boolean, _value} -> boolean == keep_or_discard end)
    |> elem(0)
    |> Keyword.get_values(keep_or_discard)
  end
end
