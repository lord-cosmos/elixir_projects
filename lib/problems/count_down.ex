defmodule Countdown do
  def sleep(seconds) do
    receive do
      after seconds*1000 -> nil end
    end
  def say(text) do
    spawn fn -> :os.cmd('say #{text}') end
  end
  def timer do
    Stream.resource(
      fn -> # the number of seconds to the start of the next minute
        {_h,_m,s} = :erlang.time
        60 - s - 1
      end,
      fn
        0 ->
          {:halt, 0}
        count ->
          sleep(1) # wait for the next second, then return its countdown
          { [inspect(count)], count - 1 }
      end,
      fn _ -> nil end # nothing to deallocate
    )
  end
end

#  run below in iex after compiling this file
# counter = Countdown.timer
# #Function<52.53678557/2 in Stream.resource/3>
# iex(2)> printer = counter |> Stream.each(&IO.puts/1)
# #Stream<[
#   enum: #Function<52.53678557/2 in Stream.resource/3>,
#   funs: [#Function<39.53678557/1 in Stream.each/2>]
# ]>
# iex(3)> speaker = printer |> Stream.each(&Countdown.say/1)
# #Stream<[
#   enum: #Function<52.53678557/2 in Stream.resource/3>,
#   funs: [#Function<39.53678557/1 in Stream.each/2>,
#    #Function<39.53678557/1 in Stream.each/2>]
# ]>
# iex(4)>  speaker |> Enum.take(5)
# 37
# 36
# 35
# 34
# 33
# ["37", "36", "35", "34", "33"]
