# Link :  https://www.hackerrank.com/challenges/fp-reverse-a-list/


defmodule Problems.ReverseList do
  def takeInteger() do
      IO.gets("") |> String.trim() |> String.to_integer()
  end

  def takeInput() do
    list = IO.reads(:stdio, :all)
          |> String.split
          |> Enum.map(&String.to_integer(&1))
    reverseList(list)
  end

  def reverseList(list) when is_list(list) do
      reverse_list(list, [])

  end

  defp reverse_list([], reversed), do: reversed
  defp reverse_list([head | tail ], reversed), do: reverse_list(tail, [head | reversed])

  defp printIntegers(list) do
    Enum.each(list, fn el -> IO.puts el end)
  end
end
