defmodule BettingSystem.Bet do
  use Ecto.Schema
  import Ecto.Changeset

  schema "bets" do
    field :amount, :decimal
    field :status, :string
    field :user_id, :id
    field :game_id, :id

    timestamps()
  end

  @doc false
  def changeset(bet, attrs) do
    bet
    |> cast(attrs, [:amount, :status])
    |> validate_required([:amount, :status])
  end
end
