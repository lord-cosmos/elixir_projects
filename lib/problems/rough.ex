defmodule WeatherHistory do
  @spec for_location_27(list()) :: [[...]]

  # the below are specific to 27 location.
  def for_location_27([]), do: []
  def for_location_27([[time, 27, temp,rain] | tail ]), do: [[time, 27, temp, rain] | for_location_27(tail)]
  def for_location_27([ _ | tail]), do: for_location_27(tail)
  def test_data do [
    [1366225622, 26, 15, 0.125],
    [1366225622, 27, 15, 0.45],
    [1366225622, 28, 21, 0.25],
    [1366229222, 26, 19, 0.081],
    [1366229222, 27, 17, 0.468],
    [1366229222, 28, 15, 0.60],
    [1366232822, 26, 22, 0.095],
    [1366232822, 27, 21, 0.05],
    [1366232822, 28, 24, 0.03],
    [1366236422, 26, 17, 0.025]
 ]
   end


  # lets generalise it.
   def for_location([], _target_loc), do: []

  #  can improve below line
  #  def for_location([[time, target_loc, temp, rain] | tail ], target_loc), do: [[time, target_loc, temp, rain] | for_location(tail, target_loc)]
  #  to
  def for_location([ head = [_, target_loc, _, _ ] | tail], target_loc) do
    [ head | for_location(tail, target_loc) ]
  end

  def for_location([_ | tail], target_loc), do: for_location(tail, target_loc)

end


defmodule Canvas do
  # keyword list
  @defaults [ fg: "black", bg: "white", font: "Merriweather" ]
  @spec draw_text(any(), keyword()) :: :ok
  @spec draw_text(any()) :: :ok
  def draw_text(text, options \\ []) do
    # using Keyword module
    options = Keyword.merge(@defaults, options)
    IO.puts "Drawing text #{inspect(text)}"
    IO.puts "Foreground: #{options[:fg]}"
    IO.puts "Background: #{Keyword.get(options, :bg)}"
    IO.puts "Font: #{Keyword.get(options, :font)}"
    IO.puts "Pattern: #{Keyword.get(options, :pattern, "solid")}"
    IO.puts "Style: #{inspect Keyword.get_values(options, :style)}"
  end
end

#  some pattern matching on maps.
people = [
  %{ name: "Grumpy", height: 1.24},
  %{ name: "Dave", height: 1.88},
  %{ name: "Dopey", height: 1.32},
  %{ name: "Shaquille", height: 2.16 },
  %{ name: "Sneezy", height: 1.28 }
  ]
# comprehension with filter.
IO.inspect(for person = %{ height: height } <- people, height > 1.5, do: person)


# Pattern matching can’t bind keys
# %{ item => :ok } = %{ 1 => :ok, 2 => :error }
# gives error


defmodule Attendee do
  defstruct name: "", paid: false, over_18: true
  def may_attend_after_party(attendee= %Attendee{}) do
    attendee.paid && attendee.over_18
  end

  def print_vip_badge(%Attendee{name: name}) when name != "" do
    IO.puts "Very cheap badge for #{name}"
  end

  def print_vip_badge(%Attendee{}), do: raise "missing name for the badge."
end


defmodule Customer do
  defstruct name: "", company: ""
end

defmodule BugReport do
  defstruct owner: %Customer{}, details: '', severity: 1
end

# report = %BugReport{owner: %Customer{name: "Dave", company: "Pragmatic"}, details: "broken"}

#  to access nested fields
# report.owner.company

# put_in(report.owner.company, "PragProg")

cast = [
  %{
     character: "Buttercup",
     actor: %{
       first: "Robin",
       last:  "Wright"
     },
     role: "princess"
    },
    %{
     character: "Westley",
     actor: %{
       first: "Cary",
       last:  "Elwes"
     },
     role: "farm boy"
  }
]
IO.inspect get_in(cast, [Access.all(), :character])
#=> ["Buttercup", "Westley"]
IO.inspect get_in(cast, [Access.at(1), :role])
#=> "farm boy"
IO.inspect get_and_update_in(cast, [Access.all(), :actor, :last],
fn (val) -> {val, String.upcase(val)} end)

#=> {["Wright", "Elwes"],
# [%{actor: %{first: "Robin", last: "WRIGHT"}, character: "Buttercup",
#   role: "princess"},
# %{actor: %{first: "Cary", last: "ELWES"}, character: "Westley",
#   role: "farm boy"}]}
#   role: "farm boy"}]}
