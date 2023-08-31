defmodule BettingSystem.Bets.Bet do
  use Ecto.Schema

  schema "bets" do
    field :amount, :integer
    field :outcome, :string
    field :won, :boolean, default: false

    belongs_to :user, BettingSystem.Accounts.User
    belongs_to :game, BettingSystem.Sports.Game

    timestamps()
  end
end
