defmodule ExpenseTracker.FamilyTest do
  use ExpenseTracker.DataCase

  alias ExpenseTracker.Family

  describe "households" do
    alias ExpenseTracker.Family.Household

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def household_fixture(attrs \\ %{}) do
      {:ok, household} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Family.create_household()

      household
    end

    test "list_households/0 returns all households" do
      household = household_fixture()
      assert Family.list_households() == [household]
    end

    test "get_household!/1 returns the household with given id" do
      household = household_fixture()
      assert Family.get_household!(household.id) == household
    end

    test "create_household/1 with valid data creates a household" do
      assert {:ok, %Household{} = household} = Family.create_household(@valid_attrs)
      assert household.name == "some name"
    end

    test "create_household/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Family.create_household(@invalid_attrs)
    end

    test "update_household/2 with valid data updates the household" do
      household = household_fixture()
      assert {:ok, %Household{} = household} = Family.update_household(household, @update_attrs)
      assert household.name == "some updated name"
    end

    test "update_household/2 with invalid data returns error changeset" do
      household = household_fixture()
      assert {:error, %Ecto.Changeset{}} = Family.update_household(household, @invalid_attrs)
      assert household == Family.get_household!(household.id)
    end

    test "delete_household/1 deletes the household" do
      household = household_fixture()
      assert {:ok, %Household{}} = Family.delete_household(household)
      assert_raise Ecto.NoResultsError, fn -> Family.get_household!(household.id) end
    end

    test "change_household/1 returns a household changeset" do
      household = household_fixture()
      assert %Ecto.Changeset{} = Family.change_household(household)
    end
  end

  describe "userhouseholds" do
    alias ExpenseTracker.Family.UserHousehold

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def user_household_fixture(attrs \\ %{}) do
      {:ok, user_household} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Family.create_user_household()

      user_household
    end

    test "list_userhouseholds/0 returns all userhouseholds" do
      user_household = user_household_fixture()
      assert Family.list_userhouseholds() == [user_household]
    end

    test "get_user_household!/1 returns the user_household with given id" do
      user_household = user_household_fixture()
      assert Family.get_user_household!(user_household.id) == user_household
    end

    test "create_user_household/1 with valid data creates a user_household" do
      assert {:ok, %UserHousehold{} = user_household} = Family.create_user_household(@valid_attrs)
    end

    test "create_user_household/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Family.create_user_household(@invalid_attrs)
    end

    test "update_user_household/2 with valid data updates the user_household" do
      user_household = user_household_fixture()
      assert {:ok, %UserHousehold{} = user_household} = Family.update_user_household(user_household, @update_attrs)
    end

    test "update_user_household/2 with invalid data returns error changeset" do
      user_household = user_household_fixture()
      assert {:error, %Ecto.Changeset{}} = Family.update_user_household(user_household, @invalid_attrs)
      assert user_household == Family.get_user_household!(user_household.id)
    end

    test "delete_user_household/1 deletes the user_household" do
      user_household = user_household_fixture()
      assert {:ok, %UserHousehold{}} = Family.delete_user_household(user_household)
      assert_raise Ecto.NoResultsError, fn -> Family.get_user_household!(user_household.id) end
    end

    test "change_user_household/1 returns a user_household changeset" do
      user_household = user_household_fixture()
      assert %Ecto.Changeset{} = Family.change_user_household(user_household)
    end
  end
end
