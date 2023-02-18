defmodule Waitlist.Repo.Migrations.CreateLocations do
  use Ecto.Migration

  def change do
    create table(:locations) do
      add :name, :string
      add :address_id, references(:addresses, on_delete: :nothing)
      add :provider_id, references(:providers, on_delete: :nothing)

      timestamps()
    end

    create index(:locations, [:address_id])
    create index(:locations, [:provider_id])
  end
end
