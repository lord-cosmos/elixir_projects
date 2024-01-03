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
comprehensions
strings
date and time
iex helpers

---

In Elixir, there isn't a direct function named is_string to check if a variable is a string. Instead, you can use the is_binary function to check if a variable is of binary type, which includes strings since strings in Elixir are represented as binaries.

The reason for this behavior is that Elixir pattern-matches the arguments that a function is called with against the arity the function is defined with.

When matching on tuples, you need to provide a pattern which matches the entire tuple structure. You can use \_, which is the "catch-all" pattern, but you'll still need to provide it for all elements of the tuple. When matching on lists, you must match on either all elements when using the [a, b, c] = [1, 2, 3] syntax, or on the head and tail, using the [h|t] = [1, 2, 3] syntax. When matching maps though, you can match on one or more keys in the map, which gives you the %{a: b} = %{a: :foo, b: :bar} syntax.

The semantics are a bit different between data structures, but are fairly common sense. The tuple rule exists because two tuples cannot be the same unless they have the same number of elements, a list has the same limitation, but because of the semantics of lists, accessing the head element of the list is the most common operation when working with them, hence the [h|t] syntax. Maps however can match based on specific keys, so the number of elements are irrelevant, as long as both sides of the match contain the same key, and optional pattern for the value, then it's a successful match.

It is possible to nest modules in Elixir, allowing you to further namespace your functionality.

---

Submited a PR to ElixirSchool -- Jan 2 8:59pm
