defmodule ExpenseTracker.Family.UserHousehold do
  use Ecto.Schema
  import Ecto.Changeset

  schema "userhouseholds" do
    belongs_to :user, ExpenseTracker.Accounts.User
    belongs_to :household, ExpenseTracker.Family.Household

    timestamps()
  end

  @doc false
  def changeset(user_household, attrs) do
    user_household
    |> cast(attrs, [])
    |> validate_required([])
  end
end
