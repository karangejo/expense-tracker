defmodule ExpenseTracker.MembershipTest do
  use ExpenseTracker.DataCase

  alias ExpenseTracker.Membership

  describe "householdmembers" do
    alias ExpenseTracker.Membership.Householdmember

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def householdmember_fixture(attrs \\ %{}) do
      {:ok, householdmember} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Membership.create_householdmember()

      householdmember
    end

    test "list_householdmembers/0 returns all householdmembers" do
      householdmember = householdmember_fixture()
      assert Membership.list_householdmembers() == [householdmember]
    end

    test "get_householdmember!/1 returns the householdmember with given id" do
      householdmember = householdmember_fixture()
      assert Membership.get_householdmember!(householdmember.id) == householdmember
    end

    test "create_householdmember/1 with valid data creates a householdmember" do
      assert {:ok, %Householdmember{} = householdmember} = Membership.create_householdmember(@valid_attrs)
    end

    test "create_householdmember/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Membership.create_householdmember(@invalid_attrs)
    end

    test "update_householdmember/2 with valid data updates the householdmember" do
      householdmember = householdmember_fixture()
      assert {:ok, %Householdmember{} = householdmember} = Membership.update_householdmember(householdmember, @update_attrs)
    end

    test "update_householdmember/2 with invalid data returns error changeset" do
      householdmember = householdmember_fixture()
      assert {:error, %Ecto.Changeset{}} = Membership.update_householdmember(householdmember, @invalid_attrs)
      assert householdmember == Membership.get_householdmember!(householdmember.id)
    end

    test "delete_householdmember/1 deletes the householdmember" do
      householdmember = householdmember_fixture()
      assert {:ok, %Householdmember{}} = Membership.delete_householdmember(householdmember)
      assert_raise Ecto.NoResultsError, fn -> Membership.get_householdmember!(householdmember.id) end
    end

    test "change_householdmember/1 returns a householdmember changeset" do
      householdmember = householdmember_fixture()
      assert %Ecto.Changeset{} = Membership.change_householdmember(householdmember)
    end
  end
end
