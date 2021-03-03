defmodule ExpenseTrackerWeb.PaymentLive.FormComponent do
  use ExpenseTrackerWeb, :live_component

  alias ExpenseTracker.Expenses
  alias ExpenseTracker.Family

  @impl true
  def update(%{payment: payment, current_user: current_user} = assigns, socket) do
    changeset = Expenses.change_payment(payment)
    category_options = ["groceries", "tools","housing","transportation","food","utilities","insurance","medical/healthcare","savings/investing","fun/entertainment","clothing","personal","education","gift"]
    payment_type_options = ["cash", "credit","crypto","paypal"]
    households = Family.list_households_by_user_membership(current_user)
    household_options = Enum.map(households, fn x ->  [key: x.household_name,  value: x.id] end)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)
     |> assign(:payment_type_options, payment_type_options)
     |> assign(:household_options, household_options)
     |> assign(:category_options, category_options)}
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

  defp save_payment(socket, :new, payment_params = %{"household_id" => household_id}) do
    IO.inspect(payment_params)
    household = Family.get_household!(household_id)
    IO.inspect(payment_params)
    case Expenses.create_payment(socket.assigns.current_user, household, payment_params) do
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
