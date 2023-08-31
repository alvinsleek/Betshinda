defmodule BettingSystemWeb.AccountManagementLive.FormComponent do
  use BettingSystemWeb, :live_component

  alias BettingSystem.Accounts

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage account_management records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="account_management-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:first_name]} type="text" label="First name" />
        <.input field={@form[:last_name]} type="text" label="Last name" />
        <.input field={@form[:email]} type="text" label="Email" />
        <.input field={@form[:msisdn]} type="text" label="Msisdn" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Account management</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{account_management: account_management} = assigns, socket) do
    changeset = Accounts.change_account_management(account_management)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"account_management" => account_management_params}, socket) do
    changeset =
      socket.assigns.account_management
      |> Accounts.change_account_management(account_management_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"account_management" => account_management_params}, socket) do
    save_account_management(socket, socket.assigns.action, account_management_params)
  end

  defp save_account_management(socket, :edit, account_management_params) do
    case Accounts.update_account_management(socket.assigns.account_management, account_management_params) do
      {:ok, account_management} ->
        notify_parent({:saved, account_management})

        {:noreply,
         socket
         |> put_flash(:info, "Account management updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_account_management(socket, :new, account_management_params) do
    case Accounts.create_account_management(account_management_params) do
      {:ok, account_management} ->
        notify_parent({:saved, account_management})

        {:noreply,
         socket
         |> put_flash(:info, "Account management created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
