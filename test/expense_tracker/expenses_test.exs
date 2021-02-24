defmodule ExpenseTracker.ExpensesTest do
  use ExpenseTracker.DataCase

  alias ExpenseTracker.Expenses

  describe "payments" do
    alias ExpenseTracker.Expenses.Payment

    @valid_attrs %{amount: 42, category: "some category", name: "some name", payment_type: "some payment_type", purchase_date: ~D[2010-04-17], purchase_time: ~T[14:00:00]}
    @update_attrs %{amount: 43, category: "some updated category", name: "some updated name", payment_type: "some updated payment_type", purchase_date: ~D[2011-05-18], purchase_time: ~T[15:01:01]}
    @invalid_attrs %{amount: nil, category: nil, name: nil, payment_type: nil, purchase_date: nil, purchase_time: nil}

    def payment_fixture(attrs \\ %{}) do
      {:ok, payment} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Expenses.create_payment()

      payment
    end

    test "list_payments/0 returns all payments" do
      payment = payment_fixture()
      assert Expenses.list_payments() == [payment]
    end

    test "get_payment!/1 returns the payment with given id" do
      payment = payment_fixture()
      assert Expenses.get_payment!(payment.id) == payment
    end

    test "create_payment/1 with valid data creates a payment" do
      assert {:ok, %Payment{} = payment} = Expenses.create_payment(@valid_attrs)
      assert payment.amount == 42
      assert payment.category == "some category"
      assert payment.name == "some name"
      assert payment.payment_type == "some payment_type"
      assert payment.purchase_date == ~D[2010-04-17]
      assert payment.purchase_time == ~T[14:00:00]
    end

    test "create_payment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Expenses.create_payment(@invalid_attrs)
    end

    test "update_payment/2 with valid data updates the payment" do
      payment = payment_fixture()
      assert {:ok, %Payment{} = payment} = Expenses.update_payment(payment, @update_attrs)
      assert payment.amount == 43
      assert payment.category == "some updated category"
      assert payment.name == "some updated name"
      assert payment.payment_type == "some updated payment_type"
      assert payment.purchase_date == ~D[2011-05-18]
      assert payment.purchase_time == ~T[15:01:01]
    end

    test "update_payment/2 with invalid data returns error changeset" do
      payment = payment_fixture()
      assert {:error, %Ecto.Changeset{}} = Expenses.update_payment(payment, @invalid_attrs)
      assert payment == Expenses.get_payment!(payment.id)
    end

    test "delete_payment/1 deletes the payment" do
      payment = payment_fixture()
      assert {:ok, %Payment{}} = Expenses.delete_payment(payment)
      assert_raise Ecto.NoResultsError, fn -> Expenses.get_payment!(payment.id) end
    end

    test "change_payment/1 returns a payment changeset" do
      payment = payment_fixture()
      assert %Ecto.Changeset{} = Expenses.change_payment(payment)
    end
  end
end
