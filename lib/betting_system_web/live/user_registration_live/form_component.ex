defmodule BettingSystemWeb.UserRegistrationLive.FormComponent do
  use BettingSystemWeb, :live_component

  alias BettingSystem.Auth

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage user_registration records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="user_registration-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:first_name]} type="text" label="First name" />
        <.input field={@form[:last_name]} type="text" label="Last name" />
        <.input field={@form[:email]} type="text" label="Email" />
        <.input field={@form[:msisdn]} type="text" label="Msisdn" />
        <:actions>
          <.button phx-disable-with="Saving...">Save User registration</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{user_registration: user_registration} = assigns, socket) do
    changeset = Auth.change_user_registration(user_registration)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"user_registration" => user_registration_params}, socket) do
    changeset =
      socket.assigns.user_registration
      |> Auth.change_user_registration(user_registration_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"user_registration" => user_registration_params}, socket) do
    save_user_registration(socket, socket.assigns.action, user_registration_params)
  end

  defp save_user_registration(socket, :edit, user_registration_params) do
    case Auth.update_user_registration(socket.assigns.user_registration, user_registration_params) do
      {:ok, user_registration} ->
        notify_parent({:saved, user_registration})

        {:noreply,
         socket
         |> put_flash(:info, "User registration updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_user_registration(socket, :new, user_registration_params) do
    case Auth.create_user_registration(user_registration_params) do
      {:ok, user_registration} ->
        notify_parent({:saved, user_registration})

        {:noreply,
         socket
         |> put_flash(:info, "User registration created successfully")
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
