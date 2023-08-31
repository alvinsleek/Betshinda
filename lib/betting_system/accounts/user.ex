defmodule BettingSystem.Accounts.User do
  use Ecto.Schema

  schema "users" do
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    field :msisdn, :string
    field :admin_access, :boolean, default: false

    has_many :bets, BettingSystem.Bets.Bet

    timestamps()
  end

end
