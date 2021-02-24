defmodule ExpenseTracker.Family do
  @moduledoc """
  The Family context.
  """

  import Ecto.Query, warn: false
  alias ExpenseTracker.Repo

  alias ExpenseTracker.Family.Household

  @doc """
  Returns the list of households.

  ## Examples

      iex> list_households()
      [%Household{}, ...]

  """
  def list_households do
    Repo.all(Household)
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

  @doc """
  Creates a household.

  ## Examples

      iex> create_household(%{field: value})
      {:ok, %Household{}}

      iex> create_household(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_household(attrs \\ %{}) do
    %Household{}
    |> Household.changeset(attrs)
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

  alias ExpenseTracker.Family.UserHousehold

  @doc """
  Returns the list of userhouseholds.

  ## Examples

      iex> list_userhouseholds()
      [%UserHousehold{}, ...]

  """
  def list_userhouseholds do
    Repo.all(UserHousehold)
  end

  @doc """
  Gets a single user_household.

  Raises `Ecto.NoResultsError` if the User household does not exist.

  ## Examples

      iex> get_user_household!(123)
      %UserHousehold{}

      iex> get_user_household!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user_household!(id), do: Repo.get!(UserHousehold, id)

  @doc """
  Creates a user_household.

  ## Examples

      iex> create_user_household(%{field: value})
      {:ok, %UserHousehold{}}

      iex> create_user_household(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user_household(attrs \\ %{}) do
    %UserHousehold{}
    |> UserHousehold.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user_household.

  ## Examples

      iex> update_user_household(user_household, %{field: new_value})
      {:ok, %UserHousehold{}}

      iex> update_user_household(user_household, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user_household(%UserHousehold{} = user_household, attrs) do
    user_household
    |> UserHousehold.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user_household.

  ## Examples

      iex> delete_user_household(user_household)
      {:ok, %UserHousehold{}}

      iex> delete_user_household(user_household)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user_household(%UserHousehold{} = user_household) do
    Repo.delete(user_household)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user_household changes.

  ## Examples

      iex> change_user_household(user_household)
      %Ecto.Changeset{data: %UserHousehold{}}

  """
  def change_user_household(%UserHousehold{} = user_household, attrs \\ %{}) do
    UserHousehold.changeset(user_household, attrs)
  end
end
