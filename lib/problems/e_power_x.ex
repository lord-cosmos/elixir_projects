defmodule Problems.EPowerX do
  defp read_integer, do: IO.gets("") |> String.trim() |> String.to_integer()

  def takeInput() do
    n = read_integer()
    list =
      Enum.map(1..n, fn _ ->
        IO.gets("") |> String.trim() |> String.to_float()
      end)
    printIntegers(list)
  end

  def e_power_x(x) do
    1 + Enum.sum(Enum.map(0..9, fn n -> :math.pow(x, n) / Enum.reduce(1..n, 1, &(&1 * &2)) end))
  end

  def printIntegers(list) do
    result = Enum.map(list, fn e -> e_power_x(e) end)
    Enum.each(result, &IO.puts/1)
  end
end

# Problems.EPowerX.takeInput()
