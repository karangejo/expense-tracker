defmodule ExpenseTrackerWeb.PaymentLive.Index do
  use ExpenseTrackerWeb, :live_view

  alias ExpenseTracker.Expenses
  alias ExpenseTracker.Expenses.Payment
  alias ExpenseTracker.Accounts

  @impl true
  def mount(_params, session, socket) do
    case Map.fetch(session, "user_token") do
      {:ok, token} ->
        user = Accounts.get_user_by_session_token(token)
        {:ok, assign(socket, current_user: user)
              |> assign(:payments, list_payments())}
      :error ->
        {:ok, socket}
    end
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Payment")
    |> assign(:payment, Expenses.get_payment!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Payment")
    |> assign(:payment, %Payment{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Payments")
    |> assign(:payment, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    payment = Expenses.get_payment!(id)
    {:ok, _} = Expenses.delete_payment(payment)

    {:noreply, assign(socket, :payments, list_payments())}
  end

  defp list_payments do
    Expenses.list_payments()
  end
end
