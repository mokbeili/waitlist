defmodule Waitlist.Addresses.Address do
  use Ecto.Schema
  import Ecto.Changeset

  schema "addresses" do
    field :city, :string
    field :latitude, :float
    field :lineOne, :string
    field :lineTwo, :string
    field :longitude, :float
    field :postalCode, :string
    field :province, :string
    field :unit, :string
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(address, attrs) do
    address
    |> cast(attrs, [:lineOne, :lineTwo, :unit, :city, :postalCode, :province, :latitude, :longitude])
    |> validate_required([:lineOne, :city, :postalCode, :province])
  end
end
