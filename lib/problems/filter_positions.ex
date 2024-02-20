
# Link :  https://www.hackerrank.com/challenges/fp-filter-positions-in-a-list/

defmodule Problems.FilterPositions do
  def takeInteger() do
      IO.get("") |> String.trim() |> String.to_integer()
  end

  def takeInput() do
      list = IO.read(:stdio, :all)
      |> String.split
      |> Enum.map(&String.to_integer(&1))

      printIntegers(list)
  end

  def printIntegers(list) do
      result = Enum.filter(Enum.with_index(list), fn {_ , index} -> rem(index + 1, 2) == 0 end)
      |> Enum.map(fn {el, _ } -> el end )

      Enum.each(result, fn e -> IO.puts e end )
  end
end

Problems.FilterPositions.takeInput()
