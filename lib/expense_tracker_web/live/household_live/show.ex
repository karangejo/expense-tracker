defmodule ExpenseTrackerWeb.HouseholdLive.Show do
  use ExpenseTrackerWeb, :live_view

  alias ExpenseTracker.Family
  alias ExpenseTracker.Accounts
  alias ExpenseTracker.Accounts.User
  alias ExpenseTracker.Authority
  alias ExpenseTracker.Membership

  @impl true
  def mount(_params, session, socket) do
    case Map.fetch(session, "user_token") do
      {:ok, token} ->
        user = Accounts.get_user_by_session_token(token)
        {:ok, socket
                |> assign(current_user: user)
                |> assign(user_email: "")}
      :error ->
        {:ok, socket}
    end
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    %{household: household, role: role} = Family.get_household_and_user_role!(socket.assigns.current_user, id)
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:household, household )
     |> assign(:role, role )}
  end

  @impl true
  def handle_event("add-user", _params, socket) do
    case Accounts.get_user_by_email(socket.assigns.user_email) do
      user = %User{} ->
        member = Authority.get_role_by_name!("member")
        case Membership.create_householdmember(user, member, socket.assigns.household) do
          {:ok, _membership} ->
            {:noreply,
             socket
             |> put_flash(:info, "Household and Membership created successfully")
             |> push_redirect(to: socket.assigns.return_to)}
          {:error, %Ecto.Changeset{} = changeset} ->
            {:noreply, assign(socket, changeset: changeset)}
        end
      nil ->
        {:noreply,
          socket
           |> put_flash(:info, "Could not add member to household")}
    end
  end

  @impl true
  def handle_event("change-email",%{"email" => user_email}, socket) do
    {:noreply, assign(socket, :user_email, user_email)}
  end

  defp page_title(:show), do: "Show Household"
  defp page_title(:edit), do: "Edit Household"
end
