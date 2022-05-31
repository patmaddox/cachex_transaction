defmodule CachexTransactionTest do
  use ExUnit.Case, async: false
  doctest CachexTransaction

  alias CachexTransaction.Repo
  alias CachexTransaction.Thing

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
    Ecto.Adapters.SQL.Sandbox.mode(Repo, {:shared, self()})
  end

  test "create a thing" do
    # fails with:
    #   no match of right hand side value: {:ok, {:error, "could not checkout the connection owned by #PID<0.328.0>. When using the sandbox, connections are shared,
    #   so this may imply another process is using a connection. Reason: connection not available and request was dropped from queue after 982ms.
    #   You can configure how long requests wait in the queue using :queue_target and :queue_interval. See DBConnection.start_link/2 for more information"}}
    assert Thing.create_thing(%{name: "new thing"}).name == "new thing"
  end
end
