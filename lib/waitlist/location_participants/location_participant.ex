defmodule Waitlist.LocationParticipants.LocationParticipant do
  use Ecto.Schema
  import Ecto.Changeset

  schema "location_participants" do
    field :added_at, :integer
    field :type, Ecto.Enum, values: [:waitlist, :active]
    field :participant_id, :id
    field :location_id, :id

    timestamps()
  end

  @doc false
  def changeset(location_participant, attrs) do
    location_participant
    |> cast(attrs, [:added_at, :type])
    |> validate_required([:added_at, :type])
  end
end
