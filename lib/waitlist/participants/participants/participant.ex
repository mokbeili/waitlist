defmodule Waitlist.Participants.Participants.Participant do
  use Ecto.Schema
  import Ecto.Changeset

  schema "participants" do
    field :date_of_birth, :date
    field :first_name, :string
    field :last_name, :string
    field :middle_name, :string
    field :address_id, :id
    field :guardian_id, :id

    timestamps()
  end

  @doc false
  def changeset(participant, attrs) do
    participant
    |> cast(attrs, [:first_name, :last_name, :middle_name, :date_of_birth])
    |> validate_required([:first_name, :last_name, :middle_name, :date_of_birth])
  end
end
