defmodule BettingSystem.Repo.Migrations.CreateUserLoginSessions do
  use Ecto.Migration

  def change do
    create table(:user_login_sessions) do
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:user_login_sessions, [:user_id])
  end
end
