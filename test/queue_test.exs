defmodule QueueTest do
  use ExUnit.Case
  doctest Queue

  setup do
    {:ok, queue} = Queue.new()
    [queue: queue]
  end

  test "create queue", %{queue: queue} do
    assert Queue.size(queue) == 0
  end

  test "enqueue a value", %{queue: queue} do
    :ok = Queue.enqueue(queue, 1)
    assert Queue.size(queue) == 1
  end

  test "enqueue values", %{queue: queue} do
    :ok = Queue.enqueue(queue, 1)
    :ok = Queue.enqueue(queue, 2)
    assert Queue.size(queue) == 2
  end

  test "front value", %{queue: queue} do
    :ok = Queue.enqueue(queue, 1)
    assert Queue.front(queue) == 1
    :ok = Queue.enqueue(queue, 2)
    assert Queue.front(queue) == 1
  end

  test "dequeue", %{queue: queue} do
    assert Queue.dequeue(queue) == nil
    :ok = Queue.enqueue(queue, 1)
    :ok = Queue.enqueue(queue, 12)
    assert Queue.size(queue) == 2
    assert Queue.dequeue(queue) == 1
    assert Queue.size(queue) == 1
    assert Queue.dequeue(queue) == 12
  end
end
