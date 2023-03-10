defmodule Waitlist.Providers.Locations.Location do
  alias Config.Provider
  alias Waitlist.Addresses
  use Ecto.Schema
  import Ecto.Changeset

  schema "locations" do
    field :name, :string
    belongs_to :provider, Provider
    has_one :address, Addresses.Address

    timestamps()
  end

  @doc false
  def changeset(location, attrs) do
    location
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
