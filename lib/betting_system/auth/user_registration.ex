defmodule BettingSystem.Auth.UserRegistration do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :msisdn, :string

    timestamps()
  end

  @doc false
  def changeset(user_registration, attrs) do
    user_registration
    |> cast(attrs, [:first_name, :last_name, :email, :msisdn])
    |> validate_required([:first_name, :last_name, :email, :msisdn])
  end
end
