defmodule ExpenseTracker.Family.Household do
  use Ecto.Schema
  import Ecto.Changeset

  schema "households" do
    field :household_name, :string
    belongs_to :user, ExpenseTracker.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(household, attrs) do
    household
    |> cast(attrs, [:household_name])
    |> validate_required([:household_name])
  end
end
