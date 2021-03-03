defmodule ExpenseTracker.Membership do
  @moduledoc """
  The Membership context.
  """

  import Ecto.Query, warn: false
  alias ExpenseTracker.Repo

  alias ExpenseTracker.Membership.Householdmember
  alias ExpenseTracker.Family.Household
  alias ExpenseTracker.Accounts.User
  alias ExpenseTracker.Authority.Role

  @doc """
  Returns the list of householdmembers.

  ## Examples

      iex> list_householdmembers()
      [%Householdmember{}, ...]

  """
  def list_householdmembers do
    Repo.all(Householdmember)
  end

  @doc """
  Gets a single householdmember.

  Raises `Ecto.NoResultsError` if the Householdmember does not exist.

  ## Examples

      iex> get_householdmember!(123)
      %Householdmember{}

      iex> get_householdmember!(456)
      ** (Ecto.NoResultsError)

  """
  def get_householdmember!(id), do: Repo.get!(Householdmember, id)

  @doc """
  Creates a householdmember.

  ## Examples

      iex> create_householdmember(%{field: value})
      {:ok, %Householdmember{}}

      iex> create_householdmember(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_householdmember(user = %User{}, role = %Role{}, household = %Household{}, attrs \\ %{}) do
    %Householdmember{}
    |> Householdmember.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:user, user)
    |> Ecto.Changeset.put_assoc(:role, role)
    |> Ecto.Changeset.put_assoc(:household, household)
    |> Repo.insert()
  end

  @doc """
  Updates a householdmember.

  ## Examples

      iex> update_householdmember(householdmember, %{field: new_value})
      {:ok, %Householdmember{}}

      iex> update_householdmember(householdmember, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_householdmember(%Householdmember{} = householdmember, attrs) do
    householdmember
    |> Householdmember.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a householdmember.

  ## Examples

      iex> delete_householdmember(householdmember)
      {:ok, %Householdmember{}}

      iex> delete_householdmember(householdmember)
      {:error, %Ecto.Changeset{}}

  """
  def delete_householdmember(%Householdmember{} = householdmember) do
    Repo.delete(householdmember)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking householdmember changes.

  ## Examples

      iex> change_householdmember(householdmember)
      %Ecto.Changeset{data: %Householdmember{}}

  """
  def change_householdmember(%Householdmember{} = householdmember, attrs \\ %{}) do
    Householdmember.changeset(householdmember, attrs)
  end
end
