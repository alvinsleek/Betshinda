defmodule BettingSystem.Repo.Migrations.CreateBets do
  use Ecto.Migration

  def change do
    create table(:bets) do
      add :amount, :decimal
      add :status, :string
      add :user_id, references(:users, on_delete: :nothing)
      add :game_id, references(:games, on_delete: :nothing)

      timestamps()
    end

    create index(:bets, [:user_id])
    create index(:bets, [:game_id])
  end
end
