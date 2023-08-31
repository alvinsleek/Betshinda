defmodule BettingSystemWeb.UserRegistrationLive.Index do
  use BettingSystemWeb, :live_view

  alias BettingSystem.Auth
  alias BettingSystem.Auth.UserRegistration

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :users, Auth.list_users())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit User registration")
    |> assign(:user_registration, Auth.get_user_registration!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New User registration")
    |> assign(:user_registration, %UserRegistration{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Users")
    |> assign(:user_registration, nil)
  end

  @impl true
  def handle_info({BettingSystemWeb.UserRegistrationLive.FormComponent, {:saved, user_registration}}, socket) do
    {:noreply, stream_insert(socket, :users, user_registration)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    user_registration = Auth.get_user_registration!(id)
    {:ok, _} = Auth.delete_user_registration(user_registration)

    {:noreply, stream_delete(socket, :users, user_registration)}
  end
end
