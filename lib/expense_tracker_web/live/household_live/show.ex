defmodule ExpenseTrackerWeb.HouseholdLive.Show do
  use ExpenseTrackerWeb, :live_view

  alias ExpenseTracker.Family

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:household, Family.get_household!(id))}
  end

  defp page_title(:show), do: "Show Household"
  defp page_title(:edit), do: "Edit Household"
end