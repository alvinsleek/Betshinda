defmodule BettingSystemWeb.AccountManagementLive.Show do
  use BettingSystemWeb, :live_view

  alias BettingSystem.Accounts

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:account_management, Accounts.get_account_management!(id))}
  end

  defp page_title(:show), do: "Show Account management"
  defp page_title(:edit), do: "Edit Account management"
end
