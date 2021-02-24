defmodule ExpenseTracker.Family.Household do
  use Ecto.Schema
  import Ecto.Changeset

  schema "households" do
    field :name, :string
    belongs_to :user, ExpenseTracker.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(household, attrs) do
    household
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
