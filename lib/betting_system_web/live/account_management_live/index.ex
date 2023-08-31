defmodule BettingSystemWeb.AccountManagementLive.Index do
  use BettingSystemWeb, :live_view

  alias BettingSystem.Accounts
  alias BettingSystem.Accounts.AccountManagement

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :users, Accounts.list_users())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Account management")
    |> assign(:account_management, Accounts.get_account_management!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Account management")
    |> assign(:account_management, %AccountManagement{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Users")
    |> assign(:account_management, nil)
  end

  @impl true
  def handle_info({BettingSystemWeb.AccountManagementLive.FormComponent, {:saved, account_management}}, socket) do
    {:noreply, stream_insert(socket, :users, account_management)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    account_management = Accounts.get_account_management!(id)
    {:ok, _} = Accounts.delete_account_management(account_management)

    {:noreply, stream_delete(socket, :users, account_management)}
  end
end
