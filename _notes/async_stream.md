For sending an email to 1million users : starting 1 million processes will put sudden pressure on our system resources.

> The solution to our problems is async_stream/3. It’s another very handy function from the Task module which is designed to create task processes from a list of items. For every item in the list, async_stream/3 will start a process and run the function we provide to process the item. It works just like Enum.map/2 and Task.async/2 combined, with one major difference: you can set a limit on the number of processes running at the same time

How to run the Stream?

> One way to run a stream is to use the Stream.run/1 function. However, Stream.run/1 always returns :ok so it is only useful when you are not interested in the final result. Instead, you can use Enum.to_list/1 which will try to convert the stream to a List data structure.
