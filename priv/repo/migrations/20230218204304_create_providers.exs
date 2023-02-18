defmodule Waitlist.Repo.Migrations.CreateProviders do
  use Ecto.Migration

  def change do
    create table(:providers) do
      add :name, :string
      add :licensed, :boolean, default: false, null: false
      add :user_id, references(:users, on_delete: :nothing)
      add :address_id, references(:addresses, on_delete: :nothing)

      timestamps()
    end

    create index(:providers, [:user_id])
    create index(:providers, [:address_id])
  end
end
