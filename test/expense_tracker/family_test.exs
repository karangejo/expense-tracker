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
end
