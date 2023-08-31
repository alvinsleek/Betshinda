defmodule BettingSystemWeb.UserLoginSessionLive.Index do
  use BettingSystemWeb, :live_view

  alias BettingSystem.Auth
  alias BettingSystem.Auth.UserLoginSession

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :user_login_sessions, Auth.list_user_login_sessions())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit User login session")
    |> assign(:user_login_session, Auth.get_user_login_session!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New User login session")
    |> assign(:user_login_session, %UserLoginSession{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing User login sessions")
    |> assign(:user_login_session, nil)
  end

  @impl true
  def handle_info({BettingSystemWeb.UserLoginSessionLive.FormComponent, {:saved, user_login_session}}, socket) do
    {:noreply, stream_insert(socket, :user_login_sessions, user_login_session)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    user_login_session = Auth.get_user_login_session!(id)
    {:ok, _} = Auth.delete_user_login_session(user_login_session)

    {:noreply, stream_delete(socket, :user_login_sessions, user_login_session)}
  end
end
