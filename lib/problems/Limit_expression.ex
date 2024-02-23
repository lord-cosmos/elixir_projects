defmodule Problems.LimitExpression do
  @dx 0.001

  def convert(str) do
      str |> String.split() |> Enum.map(&String.to_integer/1)
  end

  def polynomial(a,b) do
      zipped = Enum.zip(a, b)
      fn x ->
        zipped
        |> Enum.map(fn {co, exp} -> co * :math.pow(x, exp) end)
        |> Enum.sum
      end
  end

  def integral(y, r, l) do
      0..trunc((r - l) / @dx)
        |> Enum.map(fn x -> y.(l + x * @dx) * @dx end)
        |> Enum.sum
        |> Float.round(1)
  end

  def rotate(y, l, r) do
      0..trunc((r - l) / @dx)
        |> Enum.map(fn x -> :math.pi * :math.pow(y.(l + x * @dx), 2) * @dx end)
        |> Enum.sum
        |> Float.round(1)
  end

  def area(aSeq, bSeq, left, right) do
      integral(polynomial(aSeq, bSeq), left, right)
  end

  def volume(aSeq, bSeq, left, right) do
      rotate(polynomial(aSeq, bSeq), left, right)
  end
end

aSeq = IO.read(:stdio, :line) |> Problems.LimitExpression.convert
bSeq = IO.read(:stdio, :line) |> Problems.LimitExpression.convert
[left, right] = IO.read(:stdio, :line) |> Problems.LimitExpression.convert

IO.puts Problems.LimitExpression.area(aSeq, bSeq, left, right)
IO.puts Problems.LimitExpression.volume(aSeq, bSeq, left, right)
