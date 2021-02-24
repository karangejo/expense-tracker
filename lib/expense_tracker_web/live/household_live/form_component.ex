defmodule ExpenseTrackerWeb.HouseholdLive.FormComponent do
  use ExpenseTrackerWeb, :live_component

  alias ExpenseTracker.Family

  @impl true
  def update(%{household: household} = assigns, socket) do
    changeset = Family.change_household(household)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"household" => household_params}, socket) do
    changeset =
      socket.assigns.household
      |> Family.change_household(household_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"household" => household_params}, socket) do
    save_household(socket, socket.assigns.action, household_params)
  end

  defp save_household(socket, :edit, household_params) do
    case Family.update_household(socket.assigns.household, household_params) do
      {:ok, _household} ->
        {:noreply,
         socket
         |> put_flash(:info, "Household updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_household(socket, :new, household_params) do
    case Family.create_household(household_params) do
      {:ok, _household} ->
        {:noreply,
         socket
         |> put_flash(:info, "Household created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
