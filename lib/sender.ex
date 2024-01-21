defmodule Sender do
  def send_email(email) do
    Process.sleep(30_000)
    IO.puts "Email to #{email} sent"
    {:ok, "email_sent"}
  end


  def notify_all(emails) do
    Enum.each(emails, fn email ->
      Task.start(fn -> send_email(email)
      end)
    end)
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
