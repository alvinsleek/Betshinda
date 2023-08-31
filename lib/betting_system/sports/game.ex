defmodule BettingSystem.Sports.Game do
  use Ecto.Schema

  schema "games" do
    field :name, :string
    field :sport, :string
    field :start_time, :utc_datetime

    has_many :bets, BettingSystem.Bets.Bet

    timestamps()
  end
end
