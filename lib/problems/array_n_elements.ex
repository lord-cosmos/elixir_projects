# Link  : https://www.hackerrank.com/challenges/fp-array-of-n-elements/

defmodule Problems.ArrayNElements do
  def takeInteger() do
      IO.gets("") |> String.trim() |> String.to_integer()
  end

  def takeInput() do
      {:ok, n} = takeInteger()
      printList(n)
  end

  def printList(n) do
      # create an array [1,1, ... n times]and print it in same way
      result = for _ <- 1..n, do: 1
      IO.puts Enum.join(result, ", ")
  end

end


# Problems.ArrayNElements.takeInput()
