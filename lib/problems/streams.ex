defmodule Streams do
  def run() do
    Stream.cycle(~w{green white})
    |> Enum.zip(1..5)
    |> Enum.map(fn {class, val} -> "#{class} #{val}" end)
    |> IO.puts
  end
end

# <tr class="green"><td>1</td></tr>
# <tr class="white"><td>2</td></tr>
# <tr class="green"><td>3</td></tr>
# <tr class="white"><td>4</td></tr>
# <tr class="green"><td>5</td></tr>
# :ok
