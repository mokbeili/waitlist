defmodule Waitlist.Providers.Provider do
  use Ecto.Schema
  import Ecto.Changeset

  schema "providers" do
    field :licensed, :boolean, default: false
    field :name, :string
    field :user_id, :id
    field :address_id, :id

    timestamps()
  end

  @doc false
  def changeset(provider, attrs) do
    provider
    |> cast(attrs, [:name, :licensed])
    |> validate_required([:name, :licensed])
  end
end
