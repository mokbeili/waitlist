defmodule Waitlist.Providers.Provider do
  alias Waitlist.Accounts
  alias Waitlist.Addresses
  alias ElixirSense.Location
  use Ecto.Schema
  import Ecto.Changeset

  schema "providers" do
    field :licensed, :boolean, default: false
    field :name, :string
    belongs_to :user, Accounts.User
    has_many :locations, Location
    has_one :address, Addresses.Address

    timestamps()
  end

  @doc false
  def changeset(provider, attrs) do
    provider
    |> cast(attrs, [:name, :licensed])
    |> validate_required([:name, :licensed])
  end
end
