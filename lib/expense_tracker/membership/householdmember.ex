defmodule ExpenseTracker.Membership.Householdmember do
  use Ecto.Schema
  import Ecto.Changeset

  schema "householdmembers" do
    belongs_to :user, ExpenseTracker.Accounts.User
    belongs_to :household, ExpenseTracker.Family.Household
    belongs_to :role, ExpenseTracker.Authority.Role

    timestamps()
  end

  @doc false
  def changeset(householdmember, attrs) do
    householdmember
    |> cast(attrs, [])
    |> validate_required([])
  end
end
