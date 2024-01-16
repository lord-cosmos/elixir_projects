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

Basics ELIXIR :

1. Basics -- done 14 dec 2023 2:57pm
2. Collections -- done 20 dec 2023 1:13pm
3. Enum -- done 22 dec 2023 9:53pm
4. Pattern Matching -- done dec 23 2023 9:40pm
5. ControlStructures -- done dec 24 2023 9:35pm
6. functions -- done dec 25 2023 10:37pm
7. pipe operator -- done dec 27 2023 8:42pm
8. modules -- done dec 28 2023 8:03pm
9. mix -- done dec 29 2023 (no time)
10. sigils -- done Jan 1 8:47pm
11. documentation -- done Jan 2 8:59pm
12. comprehensions -- done Jan 3 9:16pm
13. strings -- done Jan 4 10:09pm
14. date and time -- done Jan 5 8:30pm
15. iex helpers -- done Jan 6 9:47pm

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

INTERMEDIATE ELIXIR :

1. Custom Mix Tasks -- done Jan 7 2024 10:53am
2. Erlang Interoperability -- done Jan 8 2024 no time
3. Error Handling -- done Jan 9 11:50am
4. Executables
5. Concurrency

Notes :

1. Mix does not automatically start our application or any of its dependencies which is fine for many Mix task use-cases but what if we need to use Ecto and interact with a database? In that case we need to make sure the app behind Ecto.Repo has started. There are 2 ways for us to handle this: explicitly starting an app or we can start our application which in turn will start the others.

To create our custom Mix task.

Create a new directory and file projectName/lib/mix/tasks/hello.ex.

```Elixir

defmodule Mix.Tasks.Hello do
  @moduledoc "The hello mix task: `mix help hello`"
  use Mix.Task

  @shortdoc "Simply calls the Hello.say/0 function."
  def run(_) do
    # This will start our application
    Mix.Task.run("app.start")

    Hello.say()
  end
end
```

Note: Our code must be compiled before new tasks will appear in the mix help output. We can do this either by running mix compile directly or by running our task as we did with mix hello, which will trigger the compilation for us.

It’s important to note that task names are derived from the module name, so Mix.Tasks.MyHelper.Utility will become my_helper.utility.

Similar to Mix and managing our dependencies, including Erlang libraries works the same way.
In the event the Erlang library has not been pushed to Hex you can refer to the git repository instead:

```Elixir
def deps do
  [{:png, github: "yuce/png"}]
end
```

Leveraging Erlang from within our Elixir applications is easy and effectively doubles the number of libraries available to us.
Difference btw Elixir and Erlang :

1. atoms `:atom` , `atom.`
2. String UTF-8 encoded binaries, char lists
3. variables can start with lowercase/upper case, Only upper case is allowed
4. Rebinging Allowed, Not allowed.

--

In Elixir, the ! (exclamation mark) at the end of a function name conventionally denotes that the function is a "bang" or "dangerous" operation. It usually indicates that the function performs an operation that can _raise errors or have side effects_.

the ? (question mark) at the end of a function name conventionally denotes that the function might deal with single-character inputs or perform some specific operation related to single characters.

Create New Error module :

```Elixir

defmodule ExampleError do
  defexception message: "an example error has occurred"
end

try do
  raise ExampleError
rescue
  e in ExampleError -> e
end

%ExampleError{message: "an example error has occurred"}


defmodule ExampleError2 do
  defexception message: "an example error 2 has occured"
end

try do
  raise ExampleError2
rescue
  e in ExampleError -> e
  e in ExampleError2 -> e
end


```

To build executables in Elixir, we will be using escript. Escript produces an executable that can be run on any system with Erlang installed.

In Elixir, the `\\` operator within function parameters is used to set default values.
I love Erlang.

Concurrency:
Processes in the Erlang VM are lightweight and run across all CPUs. While they may seem like native threads, they’re simpler and it’s not uncommon to have thousands of concurrent processes in an Elixir application.

Processes in the Erlang VM are lightweight and run across all CPUs. While they may seem like native threads, they’re simpler and it’s not uncommon to have thousands of concurrent processes in an Elixir application.

The easiest way to create a new process is spawn, which takes either an anonymous or named function. When we create a new process it returns a Process Identifier, or PID, to uniquely identify it within our application.

Advanced Elixir :

