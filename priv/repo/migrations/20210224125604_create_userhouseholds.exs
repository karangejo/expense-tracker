defmodule ExpenseTracker.Repo.Migrations.CreateUserhouseholds do
  use Ecto.Migration

  def change do
    create table(:userhouseholds) do
      add :user_id, references(:users), on_delete: :delete_all
      add :household_id, references(:households), on_delete: :delete_all

      timestamps()
    end

  end
end
