defmodule Slowmonster.Trackable do
  use Slowmonster.Web, :model

  schema "trackables" do
    field :content, :string
    field :priority, :integer
    field :closed_at, Ecto.DateTime
    field :days_in_week, :float
    belongs_to :user, Slowmonster.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:content, :priority, :closed_at, :days_in_week])
    |> validate_required([:content, :priority, :closed_at, :days_in_week])
  end
end
