defmodule BettingSystem.Auth.UserLoginSession do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_login_sessions" do

    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(user_login_session, attrs) do
    user_login_session
    |> cast(attrs, [])
    |> validate_required([])
  end
end
