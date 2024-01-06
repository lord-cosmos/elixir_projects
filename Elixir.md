Integers
floats
boolean
atoms
tuples
functions
list
string

== ===
&& || !
and or not - first arrgument must be boolean
<> string concatenation
#{name} string interpolation

Basics -- done 14 dec 2023 2:57pm
Collections -- done 20 dec 2023 1:13pm
Enum -- done 22 dec 2023 9:53pm
Pattern Matching -- done dec 23 2023 9:40pm
ControlStructures -- done dec 24 2023 9:35pm
functions -- done dec 25 2023 10:37pm
pipe operator -- done dec 27 2023 8:42pm
modules -- done dec 28 2023 8:03pm
mix -- done dec 29 2023 (no time)
sigils -- done Jan 1 8:47pm
documentation -- done Jan 2 8:59pm
comprehensions -- done Jan 3 9:16pm
strings -- done Jan 4 10:09pm
date and time -- done Jan 5 8:30pm
iex helpers

---

In Elixir, there isn't a direct function named is_string to check if a variable is a string. Instead, you can use the is_binary function to check if a variable is of binary type, which includes strings since strings in Elixir are represented as binaries.

The reason for this behavior is that Elixir pattern-matches the arguments that a function is called with against the arity the function is defined with.

When matching on tuples, you need to provide a pattern which matches the entire tuple structure. You can use \_, which is the "catch-all" pattern, but you'll still need to provide it for all elements of the tuple. When matching on lists, you must match on either all elements when using the [a, b, c] = [1, 2, 3] syntax, or on the head and tail, using the [h|t] = [1, 2, 3] syntax. When matching maps though, you can match on one or more keys in the map, which gives you the %{a: b} = %{a: :foo, b: :bar} syntax.

The semantics are a bit different between data structures, but are fairly common sense. The tuple rule exists because two tuples cannot be the same unless they have the same number of elements, a list has the same limitation, but because of the semantics of lists, accessing the head element of the list is the most common operation when working with them, hence the [h|t] syntax. Maps however can match based on specific keys, so the number of elements are irrelevant, as long as both sides of the match contain the same key, and optional pattern for the value, then it's a successful match.

It is possible to nest modules in Elixir, allowing you to further namespace your functionality.

---

Submited a PR to ElixirSchool -- Jan 2 8:59pm

---

In Elixir, <<c>> is a binary literal syntax used to represent a single byte in a binary. This syntax is commonly used when working with binary data, especially when you need to specify a single byte explicitly.

The <<c>> syntax is an Elixir shortcut to create a binary containing a single byte represented by the value of c. Here, c typically stands for an integer value representing the byte in its ASCII or Unicode code.

For example:

<<65>> represents a binary containing the byte with the decimal value 65, which corresponds to the ASCII character 'A'.
<<72, 101, 108, 108, 111>> represents a binary containing the ASCII codes for the characters 'H', 'e', 'l', 'l', 'o'.

```Elixir
> for c <- [72, 101, 108, 108, 111], into: "", do: <<c>>
"Hello"

> for c <- [81, 72, 78,89], into: "", do: <<c>>
"QHNY"
```

Usage of String.graphemes

```Elixir
defmodule Anagrams do
 def anagrams?(a,b) when is_binary(a) and is_binary(b) do:
  sort_order(a) == sort_order(b)
 end
 def sort_order(string) do
   string
   |> String.downcase()
   |> String.graphemes()
   |> Enum.sort()
 end
end
```

Example of Tzdata package leverage:

```Elixir
paris_datetime = DateTime.from_naive!(~N[2019-01-01 12:00:00], "Europe/Paris")
#DateTime<2019-01-01 12:00:00+01:00 CET Europe/Paris>
{:ok, ny_datetime} = DateTime.shift_zone(paris_datetime, "America/New_York")
{:ok, #DateTime<2019-01-01 06:00:00-05:00 EST America/New_York>}
ny_datetime
#DateTime<2019-01-01 06:00:00-05:00 EST America/New_York>
```
