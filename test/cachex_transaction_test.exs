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
    assert Thing.create_thing(%{name: "new thing"}).name == "new thing"
  end
end
