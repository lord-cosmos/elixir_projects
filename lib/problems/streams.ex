defmodule Streams do
  def cycle() do
    Stream.cycle(~w{green white})
    |> Enum.zip(1..5)
    |> Enum.map(fn {class, val} -> "#{class} #{val}" end)
    |> IO.puts
  end

  # <tr class="green"><td>1</td></tr>
  # <tr class="white"><td>2</td></tr>
  # <tr class="green"><td>3</td></tr>
  # <tr class="white"><td>4</td></tr>
  # <tr class="green"><td>5</td></tr>
  # :ok

  def repeatedly() do
    Stream.repeatedly(fn -> 1 end)
    |> Enum.take(3)
  end
  # [1, 1, 1]
  #   Stream.repeatedly(&:random.uniform/0) |> Enum.take(3)
  # [0.7230402056221108, 0.94581636451987, 0.5014907142064751]

  def iterate() do
    Stream.iterate(0, &(&1 + 1))
    |> Enum.take(5)
  end
  # [0, 1, 2, 3, 4]


  def unfold() do
    Stream.unfold({0,1} , fn {f1, f2} -> {f1 , { f2, f1+ f2}} end)
    |> Enum.take(15)
  end
  # [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377]

  def resource() do
    Stream.resource(fn -> File.open!("sample") end,
    fn file ->
      case IO.read(file, :line) do
        data when is_binary(data) -> {[data], file}
        _ -> {:halt, file}
      end
    end,
    fn file -> File.close(file) end)
  end

end


defmodule Utf8 do
  def each(str, func) when is_binary(str) do
    _each(str, func)
  end

  defp _each(<<head::utf8, tail::binary>> , func) do
    func.(head)
    _each(tail, func)
  end
  defp _each(<<>>, _func), do: []
end
