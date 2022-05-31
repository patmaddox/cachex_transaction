defmodule CachexTransaction.Thing do
  use Ecto.Schema
  import Ecto.Changeset
  alias CachexTransaction.Repo

  schema "things" do
    field(:name, :string)
  end

  def create_thing(attrs) do
    {:ok, {:ok, %__MODULE__{} = thing}} = Repo.transaction(fn ->
      Cachex.transaction(:cachex_transaction, [attrs.name], fn _worker ->
        attrs
        |> changeset()
        |> Repo.insert!()
      end)
    end)

    thing
  end

  defp changeset(struct \\ %__MODULE__{}, attrs) do
    struct
    |> cast(attrs, __schema__(:fields) -- [:id])
  end
end
