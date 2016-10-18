defmodule Slowmonster.TrackableTest do
  use Slowmonster.ModelCase

  alias Slowmonster.Trackable

  test "changeset with valid attributes" do
    params = params_for(:trackable)
    changeset = Trackable.changeset(%Trackable{}, params)

    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    params = %{}
    changeset = Trackable.changeset(%Trackable{}, params)

    refute changeset.valid?
  end
end
