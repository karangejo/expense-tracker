defmodule ExpenseTracker.Repo.Migrations.CreatePayments do
  use Ecto.Migration

  def change do
    create table(:payments) do
      add :item_name, :string
      add :category, :string
      add :purchase_date, :date
      add :purchase_time, :time
      add :amount, :integer
      add :payment_type, :string
      add :user_id, references(:users), on_delete: :delete_all
      add :household_id, references(:households), on_delete: :delete_all

      timestamps()
    end

  end
end
