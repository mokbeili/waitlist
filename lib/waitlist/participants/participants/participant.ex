defmodule Waitlist.Participants.Participants.Participant do
  alias Waitlist.Participants.Guardian
  alias Waitlist.Addresses
  use Ecto.Schema
  import Ecto.Changeset

  schema "participants" do
    field :date_of_birth, :date
    field :first_name, :string
    field :last_name, :string
    field :middle_name, :string
    belongs_to :guardian, Guardian
    belongs_to :address, Addresses.Address

    timestamps()
  end

  @doc false
  def changeset(participant, attrs) do
    participant
    |> cast(attrs, [:first_name, :last_name, :middle_name, :date_of_birth])
    |> validate_required([:first_name, :last_name, :middle_name, :date_of_birth])
  end
end
