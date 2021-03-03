defmodule ExpenseTrackerWeb.PageLive do
  use ExpenseTrackerWeb, :live_view

  alias ExpenseTracker.Accounts

  @impl true
  def mount(_params, session, socket) do
    case Map.fetch(session, "user_token") do
      {:ok, token} ->
        user = Accounts.get_user_by_session_token(token)
        {:ok, assign(socket, current_user: user)}
      :error ->
        {:ok, socket}
    end
  end

end
