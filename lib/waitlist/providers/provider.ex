defmodule Waitlist.Providers.Provider do
  use Ecto.Schema
  import Ecto.Changeset

  schema "providers" do
    field :licensed, :boolean, default: false
    field :name, :string
    belongs_to :user, User
    has_many :locations, Locations
    has_one :address, Address

    timestamps()
  end

  @doc false
  def changeset(provider, attrs) do
    provider
    |> cast(attrs, [:name, :licensed])
    |> validate_required([:name, :licensed])
  end
end
