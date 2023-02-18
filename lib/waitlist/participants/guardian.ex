defmodule Waitlist.Participants.Guardian do
  use Ecto.Schema
  import Ecto.Changeset

  schema "guardians" do
    field :date_of_birth, :date
    field :first_name, :string
    field :last_name, :string
    field :middle_name, :string
    field :address_id, :id
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(guardian, attrs) do
    guardian
    |> cast(attrs, [:first_name, :last_name, :middle_name, :date_of_birth])
    |> validate_required([:first_name, :last_name, :middle_name, :date_of_birth])
  end
end
