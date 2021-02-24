defmodule ExpenseTrackerWeb.HouseholdLive.Index do
  use ExpenseTrackerWeb, :live_view

  alias ExpenseTracker.Family
  alias ExpenseTracker.Family.Household

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :households, list_households())}
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

    {:noreply, assign(socket, :households, list_households())}
  end

  defp list_households do
    Family.list_households()
  end
end
