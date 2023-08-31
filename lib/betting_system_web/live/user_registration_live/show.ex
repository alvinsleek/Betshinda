defmodule BettingSystemWeb.UserRegistrationLive.Show do
  use BettingSystemWeb, :live_view

  alias BettingSystem.Auth

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:user_registration, Auth.get_user_registration!(id))}
  end

  defp page_title(:show), do: "Show User registration"
  defp page_title(:edit), do: "Edit User registration"
end
