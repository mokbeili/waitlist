defmodule Waitlist.Repo.Migrations.CreateGuardians do
  use Ecto.Migration

  def change do
    create table(:guardians) do
      add :first_name, :string
      add :last_name, :string
      add :middle_name, :string
      add :date_of_birth, :date
      add :address_id, references(:addresses, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:guardians, [:address_id])
    create index(:guardians, [:user_id])
  end
end
