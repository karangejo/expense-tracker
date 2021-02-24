defmodule ExpenseTrackerWeb.PaymentLive.FormComponent do
  use ExpenseTrackerWeb, :live_component

  alias ExpenseTracker.Expenses

  @impl true
  def update(%{payment: payment} = assigns, socket) do
    changeset = Expenses.change_payment(payment)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"payment" => payment_params}, socket) do
    changeset =
      socket.assigns.payment
      |> Expenses.change_payment(payment_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"payment" => payment_params}, socket) do
    save_payment(socket, socket.assigns.action, payment_params)
  end

  defp save_payment(socket, :edit, payment_params) do
    case Expenses.update_payment(socket.assigns.payment, payment_params) do
      {:ok, _payment} ->
        {:noreply,
         socket
         |> put_flash(:info, "Payment updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_payment(socket, :new, payment_params) do
    case Expenses.create_payment(payment_params) do
      {:ok, _payment} ->
        {:noreply,
         socket
         |> put_flash(:info, "Payment created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
