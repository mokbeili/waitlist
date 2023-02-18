defmodule Waitlist.Repo.Migrations.CreateParticipants do
  use Ecto.Migration

  def change do
    create table(:participants) do
      add :first_name, :string
      add :last_name, :string
      add :middle_name, :string
      add :date_of_birth, :date
      add :address_id, references(:addresses, on_delete: :nothing)
      add :guardian_id, references(:guardians, on_delete: :nothing)

      timestamps()
    end

    create index(:participants, [:address_id])
    create index(:participants, [:guardian_id])
  end
end
