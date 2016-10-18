defmodule Slowmonster.Repo.Migrations.CreateUser do
  use Ecto.Migration
  use Timex.Ecto.Timestamps

  def change do
    create table(:users) do
      add :email, :string, null: false
      add :password_hash, :string

      timestamps
    end

    create unique_index(:users, [:email])
  end
end
