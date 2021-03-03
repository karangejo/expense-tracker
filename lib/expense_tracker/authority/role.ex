defmodule ExpenseTracker.Authority.Role do
  use Ecto.Schema
  import Ecto.Changeset

  schema "roles" do
    field :role_name, :string

    timestamps()
  end

  @doc false
  def changeset(role, attrs) do
    role
    |> cast(attrs, [:role_name])
    |> validate_required([:role_name])
  end
end
