defmodule CachexTransactionTest do
  use ExUnit.Case, async: false

  alias CachexTransaction.Repo
  alias CachexTransaction.Thing

  setup tags do
    {:ok, agent} = Agent.start_link(fn -> %{} end)

    pid = Ecto.Adapters.SQL.Sandbox.start_owner!(Repo, shared: not tags[:async])
    on_exit(fn -> Ecto.Adapters.SQL.Sandbox.stop_owner(pid) end)

    %{agent: agent}
  end

  test "new process inside transaction" do
    # fails with:
    #   could not checkout the connection owned by #PID<0.328.0>. When using the sandbox, connections are shared,
    #   so this may imply another process is using a connection. Reason: connection not available and request was dropped from queue after 982ms.
    #   You can configure how long requests wait in the queue using :queue_target and :queue_interval. See DBConnection.start_link/2 for more information"}}
    Repo.transaction(fn ->
      Task.async(fn ->
        Repo.one(Thing)
      end)
      |> Task.await()
    end)
  end

  test "transaction repo" do
    Repo.transaction(fn repo ->
      Task.async(fn ->
        repo.one(Thing)
      end)
      |> Task.await()
    end)
  end

  test "existing process inside transaction", %{agent: agent} do
    Repo.transaction(fn ->
      Agent.update(agent, fn _ ->
        Repo.one(Thing)
      end)
    end)
  end

  test "allow existing process", %{agent: agent} do
    Ecto.Adapters.SQL.Sandbox.allow(Repo, self(), agent)

    Repo.transaction(fn ->
      Agent.update(agent, fn _ ->
        Repo.one(Thing)
      end)
    end)
  end

  test "allow existing process with transaction repo", %{agent: agent} do
    Ecto.Adapters.SQL.Sandbox.allow(Repo, self(), agent)

    Repo.transaction(fn repo ->
      Agent.update(agent, fn _ ->
        repo.one(Thing)
      end)
    end)
  end
end
