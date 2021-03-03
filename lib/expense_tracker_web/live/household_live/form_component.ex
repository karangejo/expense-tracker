defmodule ExpenseTrackerWeb.HouseholdLive.FormComponent do
  use ExpenseTrackerWeb, :live_component

  alias ExpenseTracker.Family
  alias ExpenseTracker.Membership
  alias ExpenseTracker.Authority

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
    IO.inspect(socket.assigns)
    case Family.create_household(socket.assigns.current_user, household_params) do
      {:ok, household} ->
        admin = Authority.get_role_by_name!("admin")
        case Membership.create_householdmember(socket.assigns.current_user, admin, household) do
          {:ok, _membership} ->
            {:noreply,
             socket
             |> put_flash(:info, "Household and Membership created successfully")
             |> push_redirect(to: socket.assigns.return_to)}
          {:error, %Ecto.Changeset{} = changeset} ->
            {:noreply, assign(socket, changeset: changeset)}
        end
      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
