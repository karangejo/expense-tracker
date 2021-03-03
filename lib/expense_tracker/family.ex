defmodule ExpenseTracker.Family do
  @moduledoc """
  The Family context.
  """

  import Ecto.Query, warn: false
  alias ExpenseTracker.Repo

  alias ExpenseTracker.Family.Household
  alias ExpenseTracker.Membership.Householdmember
  alias ExpenseTracker.Accounts.User

  @doc """
  Returns the list of households.

  ## Examples

      iex> list_households()
      [%Household{}, ...]

  """
  def list_households do
    Repo.all(Household)
  end

  def list_households_by_user_membership(user = %User{}) do
    query = from m in Householdmember,
            join: h in  assoc(m, :household),
            where: m.user_id == ^user.id,
            select: h
    Repo.all(query)
  end

  def get_household_and_user_role!(user = %User{}, id) do
    query = from m in Householdmember,
      join: h in assoc(m, :household),
      join: r in assoc(m, :role),
      where: m.user_id == ^user.id and h.id == ^id,
      select: %{household: h, role: r}
    Repo.one(query)
  end
  @doc """
  Gets a single household.

  Raises `Ecto.NoResultsError` if the Household does not exist.

  ## Examples

      iex> get_household!(123)
      %Household{}

      iex> get_household!(456)
      ** (Ecto.NoResultsError)

  """
  def get_household!(id), do: Repo.get!(Household, id)

  def get_household_by!(params), do: Repo.get_by!(Household, params)

  def get_household_by_name!(name), do: Repo.get_by!(Household, %{household_name: name})

  @doc """
  Creates a household.

  ## Examples

      iex> create_household(%{field: value})
      {:ok, %Household{}}

      iex> create_household(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_household(user = %User{}, attrs \\ %{}) do
    %Household{}
    |> Household.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:user, user)
    |> Repo.insert()
  end

  @doc """
  Updates a household.

  ## Examples

      iex> update_household(household, %{field: new_value})
      {:ok, %Household{}}

      iex> update_household(household, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_household(%Household{} = household, attrs) do
    household
    |> Household.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a household.

  ## Examples

      iex> delete_household(household)
      {:ok, %Household{}}

      iex> delete_household(household)
      {:error, %Ecto.Changeset{}}

  """
  def delete_household(%Household{} = household) do
    Repo.delete(household)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking household changes.

  ## Examples

      iex> change_household(household)
      %Ecto.Changeset{data: %Household{}}

  """
  def change_household(%Household{} = household, attrs \\ %{}) do
    Household.changeset(household, attrs)
  end
end
