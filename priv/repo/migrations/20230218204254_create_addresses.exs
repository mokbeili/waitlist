defmodule Waitlist.Repo.Migrations.CreateAddresses do
  use Ecto.Migration

  def change do
    create table(:addresses) do
      add :lineOne, :string
      add :lineTwo, :string
      add :unit, :string
      add :city, :string
      add :postalCode, :string
      add :province, :string
      add :latitude, :float
      add :longitude, :float

      timestamps()
    end
  end
end
