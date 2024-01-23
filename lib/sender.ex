defmodule Sender do
  def send_email(email) do
    Process.sleep(3000)
    IO.puts "Email to #{email} sent"
    {:ok, "email_sent"}
  end


  def notify_all(emails) do
   emails
   |> Task.async_stream(&send_email/1, max_concurrency: 1000, ordered: false)
   |> Enum.to_list()
  end

end

# Task.start or Task.async will start the process asynchronously
# To yield the result of the process start, use Task.await or Task.yield
# They both stop the program and try to retrieve the result of the task.
# The difference comes from the way they handle process timeouts.

# When using await/1 we expect a task to be finished within some time.
# By default, it is 5secs. Can change it by passing an integer with amount of ms as 2nd argument.

# You can disable the timeout by passing the atom :infinity.

# In comparison, Task.yield/1 simply returns nil if the task hasn't completed.
# The timeout this method is 5000ms but does not cause an exception and crash.
# A completed task will return either {:ok, result} or {:exit, reason}.

# the :infinity option is not allowed for yield though.

# It is a good idea to stop the task manually by calling Task.shutdown(task).
# The shutdown/1 function also accepts a timeout and gives the process a last chance to com- plete, before stopping it.
# If it completes, you will receive the result as normal.
# You can also stop a process immediately (and rather violently) by using the atom :brutal_kill as a second argument.
