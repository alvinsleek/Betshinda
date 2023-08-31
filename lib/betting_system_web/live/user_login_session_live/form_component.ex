defmodule BettingSystemWeb.UserLoginSessionLive.FormComponent do
  use BettingSystemWeb, :live_component

  alias BettingSystem.Auth

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage user_login_session records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="user_login_session-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >

        <:actions>
          <.button phx-disable-with="Saving...">Save User login session</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{user_login_session: user_login_session} = assigns, socket) do
    changeset = Auth.change_user_login_session(user_login_session)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"user_login_session" => user_login_session_params}, socket) do
    changeset =
      socket.assigns.user_login_session
      |> Auth.change_user_login_session(user_login_session_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"user_login_session" => user_login_session_params}, socket) do
    save_user_login_session(socket, socket.assigns.action, user_login_session_params)
  end

  defp save_user_login_session(socket, :edit, user_login_session_params) do
    case Auth.update_user_login_session(socket.assigns.user_login_session, user_login_session_params) do
      {:ok, user_login_session} ->
        notify_parent({:saved, user_login_session})

        {:noreply,
         socket
         |> put_flash(:info, "User login session updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_user_login_session(socket, :new, user_login_session_params) do
    case Auth.create_user_login_session(user_login_session_params) do
      {:ok, user_login_session} ->
        notify_parent({:saved, user_login_session})

        {:noreply,
         socket
         |> put_flash(:info, "User login session created successfully")
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
