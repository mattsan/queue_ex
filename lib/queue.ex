defmodule Queue do
  @moduledoc """
  Documentation for Queue.
  """

  use Agent

  defstruct input: [], output: []

  def new do
    Agent.start_link(fn -> %Queue{} end)
  end

  def size(queue) do
    Agent.get(queue, fn %{input: input, output: output} -> Enum.count(input) + Enum.count(output) end)
  end

  def enqueue(queue, value) do
    Agent.update(queue, fn %{input: input, output: output} -> %Queue{input: [value|input], output: output} end)
  end

  def dequeue(queue) do
    Agent.get_and_update(queue, fn
      %{input: [], output: []} = q ->
        {:nil, q}
      %{input: input, output: []} ->
        [value|rest] = Enum.reverse(input)
        {value, %Queue{input: [], output: rest}}
      %{input: input, output: [value|rest]} ->
        {value, %Queue{input: input, output: rest}}
    end)
  end

  def front(queue) do
    %{output: output} = reload(queue)
    case output do
      [] -> :nil
      [value|_] -> value
    end
  end

  defp reload(queue) do
    case Agent.get(queue, &(&1)) do
      %Queue{input: input, output: []} ->
        new_struct = %Queue{input: [], output: Enum.reverse(input)}
        Agent.update(queue, fn _ -> new_struct end)
        new_struct
      q ->
        q
    end
  end
end
