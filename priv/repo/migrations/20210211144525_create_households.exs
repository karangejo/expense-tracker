defmodule ExpenseTracker.Repo.Migrations.CreateHouseholds do
  use Ecto.Migration

  def change do
    create table(:households) do
      add :household_name, :string
      add :user_id, references(:users), on_delete: :delete_all

      timestamps()
    end

  end
end
