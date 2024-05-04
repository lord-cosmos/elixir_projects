defmodule Counter do
  defstruct count: 0
 def incrementBy(counter, by) when is_integer(by) do
    %{counter | count: counter.count + by}
  end

  def incrementBy(counter, by) when is_float(by) do
    %{counter | count: counter.count + (by)}
  end


  def decrementBy(counter, by) when is_integer(by) do
    %{counter | count: counter.count - by }
  end

end

defmodule Main do
  def run() do
    counter = %Counter{}
    counter = Counter.incrementBy(counter, 5.00)
    IO.puts(counter.count)

    counter2 = Counter.decrementBy(counter, 3)
    IO.puts counter2.count
  end
end

# Main.run()
