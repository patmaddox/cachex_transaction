defmodule CachexTransaction.Thing do
  use Ecto.Schema
  import Ecto.Changeset
  alias CachexTransaction.Repo

  schema "things" do
    field :name, :string
  end

  def create_thing(attrs) do
    case Cachex.get(:cachex_transaction, attrs.name) do
      {:ok, nil} ->
        thing =
          attrs
          |> changeset()
          |> Repo.insert!()
        Cachex.put(:cachex_transaction, attrs.name, thing)
        thing
      {:ok, thing} -> thing
    end
  end

  defp changeset(struct \\ %__MODULE__{}, attrs) do
    struct
    |> cast(attrs, __schema__(:fields) -- [:id])
  end
end
