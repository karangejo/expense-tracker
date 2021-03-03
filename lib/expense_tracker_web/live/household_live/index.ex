defmodule ExpenseTrackerWeb.HouseholdLive.Index do
  use ExpenseTrackerWeb, :live_view

  alias ExpenseTracker.Family
  alias ExpenseTracker.Family.Household
  alias ExpenseTracker.Accounts
  alias ExpenseTracker.Accounts.User

  @impl true
  def mount(_params, session, socket) do
    case Map.fetch(session, "user_token") do
      {:ok, token} ->
        user = Accounts.get_user_by_session_token(token)
        {:ok, assign(socket, current_user: user)
              |> assign(:households, list_households(user))}
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
    |> assign(:page_title, "Edit Household")
    |> assign(:household, Family.get_household!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Household")
    |> assign(:household, %Household{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Households")
    |> assign(:household, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    household = Family.get_household!(id)
    {:ok, _} = Family.delete_household(household)

    {:noreply, assign(socket, :households, list_households(socket.assigns.current_user))}
  end

  defp list_households(user = %User{}) do
    Family.list_households_by_user_membership(user)
    |> IO.inspect()
  end

end
