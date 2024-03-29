defmodule Slowmonster.Repo.Migrations.CreateSession do
  use Ecto.Migration
  use Timex.Ecto.Timestamps

  def change do
    create table(:sessions) do
      add :token, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:sessions, [:user_id])
    create index(:sessions, [:token])
  end
end
