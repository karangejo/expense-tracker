defmodule ExpenseTracker.Expenses.Payment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "payments" do
    field :amount, :integer
    field :category, :string
    field :name, :string
    field :payment_type, :string
    field :purchase_date, :date
    field :purchase_time, :time
    belongs_to :user, ExpenseTracker.Accounts.User
    belongs_to :household, ExpenseTracker.Family.Household

    timestamps()
  end

  @doc false
  def changeset(payment, attrs) do
    payment
    |> cast(attrs, [:name, :category, :purchase_date, :purchase_time, :amount, :payment_type])
    |> validate_required([:name, :category, :purchase_date, :purchase_time, :amount, :payment_type])
  end
end
