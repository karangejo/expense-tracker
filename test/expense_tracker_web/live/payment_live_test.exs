defmodule ExpenseTrackerWeb.PaymentLiveTest do
  use ExpenseTrackerWeb.ConnCase

  import Phoenix.LiveViewTest

  alias ExpenseTracker.Expenses

  @create_attrs %{amount: 42, category: "some category", name: "some name", payment_type: "some payment_type", purchase_date: ~D[2010-04-17], purchase_time: ~T[14:00:00]}
  @update_attrs %{amount: 43, category: "some updated category", name: "some updated name", payment_type: "some updated payment_type", purchase_date: ~D[2011-05-18], purchase_time: ~T[15:01:01]}
  @invalid_attrs %{amount: nil, category: nil, name: nil, payment_type: nil, purchase_date: nil, purchase_time: nil}

  defp fixture(:payment) do
    {:ok, payment} = Expenses.create_payment(@create_attrs)
    payment
  end

  defp create_payment(_) do
    payment = fixture(:payment)
    %{payment: payment}
  end

  describe "Index" do
    setup [:create_payment]

    test "lists all payments", %{conn: conn, payment: payment} do
      {:ok, _index_live, html} = live(conn, Routes.payment_index_path(conn, :index))

      assert html =~ "Listing Payments"
      assert html =~ payment.category
    end

    test "saves new payment", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.payment_index_path(conn, :index))

      assert index_live |> element("a", "New Payment") |> render_click() =~
               "New Payment"

      assert_patch(index_live, Routes.payment_index_path(conn, :new))

      assert index_live
             |> form("#payment-form", payment: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#payment-form", payment: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.payment_index_path(conn, :index))

      assert html =~ "Payment created successfully"
      assert html =~ "some category"
    end

    test "updates payment in listing", %{conn: conn, payment: payment} do
      {:ok, index_live, _html} = live(conn, Routes.payment_index_path(conn, :index))

      assert index_live |> element("#payment-#{payment.id} a", "Edit") |> render_click() =~
               "Edit Payment"

      assert_patch(index_live, Routes.payment_index_path(conn, :edit, payment))

      assert index_live
             |> form("#payment-form", payment: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#payment-form", payment: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.payment_index_path(conn, :index))

      assert html =~ "Payment updated successfully"
      assert html =~ "some updated category"
    end

    test "deletes payment in listing", %{conn: conn, payment: payment} do
      {:ok, index_live, _html} = live(conn, Routes.payment_index_path(conn, :index))

      assert index_live |> element("#payment-#{payment.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#payment-#{payment.id}")
    end
  end

  describe "Show" do
    setup [:create_payment]

    test "displays payment", %{conn: conn, payment: payment} do
      {:ok, _show_live, html} = live(conn, Routes.payment_show_path(conn, :show, payment))

      assert html =~ "Show Payment"
      assert html =~ payment.category
    end

    test "updates payment within modal", %{conn: conn, payment: payment} do
      {:ok, show_live, _html} = live(conn, Routes.payment_show_path(conn, :show, payment))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Payment"

      assert_patch(show_live, Routes.payment_show_path(conn, :edit, payment))

      assert show_live
             |> form("#payment-form", payment: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#payment-form", payment: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.payment_show_path(conn, :show, payment))

      assert html =~ "Payment updated successfully"
      assert html =~ "some updated category"
    end
  end
end
