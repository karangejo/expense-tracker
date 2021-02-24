defmodule ExpenseTrackerWeb.HouseholdLiveTest do
  use ExpenseTrackerWeb.ConnCase

  import Phoenix.LiveViewTest

  alias ExpenseTracker.Family

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp fixture(:household) do
    {:ok, household} = Family.create_household(@create_attrs)
    household
  end

  defp create_household(_) do
    household = fixture(:household)
    %{household: household}
  end

  describe "Index" do
    setup [:create_household]

    test "lists all households", %{conn: conn, household: household} do
      {:ok, _index_live, html} = live(conn, Routes.household_index_path(conn, :index))

      assert html =~ "Listing Households"
      assert html =~ household.name
    end

    test "saves new household", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.household_index_path(conn, :index))

      assert index_live |> element("a", "New Household") |> render_click() =~
               "New Household"

      assert_patch(index_live, Routes.household_index_path(conn, :new))

      assert index_live
             |> form("#household-form", household: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#household-form", household: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.household_index_path(conn, :index))

      assert html =~ "Household created successfully"
      assert html =~ "some name"
    end

    test "updates household in listing", %{conn: conn, household: household} do
      {:ok, index_live, _html} = live(conn, Routes.household_index_path(conn, :index))

      assert index_live |> element("#household-#{household.id} a", "Edit") |> render_click() =~
               "Edit Household"

      assert_patch(index_live, Routes.household_index_path(conn, :edit, household))

      assert index_live
             |> form("#household-form", household: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#household-form", household: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.household_index_path(conn, :index))

      assert html =~ "Household updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes household in listing", %{conn: conn, household: household} do
      {:ok, index_live, _html} = live(conn, Routes.household_index_path(conn, :index))

      assert index_live |> element("#household-#{household.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#household-#{household.id}")
    end
  end

  describe "Show" do
    setup [:create_household]

    test "displays household", %{conn: conn, household: household} do
      {:ok, _show_live, html} = live(conn, Routes.household_show_path(conn, :show, household))

      assert html =~ "Show Household"
      assert html =~ household.name
    end

    test "updates household within modal", %{conn: conn, household: household} do
      {:ok, show_live, _html} = live(conn, Routes.household_show_path(conn, :show, household))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Household"

      assert_patch(show_live, Routes.household_show_path(conn, :edit, household))

      assert show_live
             |> form("#household-form", household: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#household-form", household: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.household_show_path(conn, :show, household))

      assert html =~ "Household updated successfully"
      assert html =~ "some updated name"
    end
  end
end
