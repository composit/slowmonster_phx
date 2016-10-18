defmodule Slowmonster.Repo.Migrations.CreateTrackable do
  use Ecto.Migration

  def change do
    create table(:trackables) do
      add :content, :string
      add :priority, :integer
      add :closed_at, :datetime
      add :days_in_week, :float
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end
    create index(:trackables, [:user_id])

  end
end
