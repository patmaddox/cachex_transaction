defmodule CachexTransaction.Thing do
  use Ecto.Schema
  import Ecto.Changeset
  alias CachexTransaction.Repo

  schema "things" do
    field :name, :string
  end

  def create_thing(attrs) do
    attrs
    |> changeset()
    |> Repo.insert!()
  end

  defp changeset(struct \\ %__MODULE__{}, attrs) do
    struct
    |> cast(attrs, __schema__(:fields) -- [:id])
  end
end
