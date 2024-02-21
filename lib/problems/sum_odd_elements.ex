defmodule Solution do

  def takeInteger() do
      IO.gets("") |> String.trim() |> String.to_integer()
  end

  def takeInput() do
      list = IO.read(:stdio, :all)
              |> String.split
              |> Enum.map(&String.to_integer/1)
      printIntegers(list)
  end

  def printIntegers(list) do
      sum = Enum.reduce(list, 0, fn (el, acc) ->
          if rem(el, 2) != 0 do
              acc + el
          else
              acc
          end
      end)
      IO.puts sum
  end
end

Solution.takeInput()
