defmodule Example2 do
  def add(a,b) do
    IO.puts a+b
  end

  def listen do
    receive do
      {:ok, "hello"} -> IO.puts "world"
      {:ok, "hi"} -> IO.puts "Dinesh"
    end

    listen()
  end
end


spawn Example2, :add, [2,3]
  