defmodule ExpenseTracker.Repo.Migrations.CreateHouseholdmembers do
  use Ecto.Migration

  def change do
    create table(:householdmembers) do

      add :user_id, references(:users), on_delete: :delete_all
      add :household_id, references(:households), on_delete: :delete_all
      add :role_id, references(:roles)
      timestamps()
    end

  end
end
