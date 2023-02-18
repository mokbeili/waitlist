defmodule Waitlist.Repo.Migrations.CreateLocationParticipants do
  use Ecto.Migration

  def change do
    create table(:location_participants) do
      add :added_at, :integer
      add :type, :string
      add :participant_id, references(:participants, on_delete: :nothing)
      add :location_id, references(:locations, on_delete: :nothing)

      timestamps()
    end

    create index(:location_participants, [:participant_id])
    create index(:location_participants, [:location_id])
  end
end
