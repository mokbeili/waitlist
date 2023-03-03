defmodule Waitlist.Repo.Migrations.AddressesAddUserColumn do
  use Ecto.Migration

  def change do
    alter table("addresses") do
      add :user_id, references(:users, on_delete: :nothing)
    end
  end
end
