defmodule Slowmonster.TrackableTest do
  use Slowmonster.ModelCase

  alias Slowmonster.Trackable

  @valid_attrs %{closed_at: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, content: "some content", days_in_week: "120.5", priority: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Trackable.changeset(%Trackable{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Trackable.changeset(%Trackable{}, @invalid_attrs)
    refute changeset.valid?
  end
end
