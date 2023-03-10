defmodule Waitlist.Participants.Guardian do
  alias Waitlist.Addresses
  alias Waitlist.Participants
  alias Waitlist.Accounts
  use Ecto.Schema
  import Ecto.Changeset


  schema "guardians" do
    field :date_of_birth, :date
    field :first_name, :string
    field :last_name, :string
    field :middle_name, :string
    belongs_to :user, Accounts.User
    has_many :participants, Participants.Participants.Participant
    belongs_to :address, Addresses.Address

    timestamps()
  end

  @doc false
  def changeset(guardian, attrs) do
    guardian
    |> cast(attrs, [:first_name, :last_name, :middle_name, :date_of_birth])
    |> validate_required([:first_name, :last_name, :date_of_birth])
  end
end
