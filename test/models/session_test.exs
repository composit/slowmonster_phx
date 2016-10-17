defmodule Slowmonster.SessionTest do
  use Slowmonster.ModelCase

  alias Slowmonster.Session

  test "changeset with valid attributes" do
    params = params_for(:session)
    changeset = Session.changeset(%Session{}, params)

    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    params = %{}
    changeset = Session.changeset(%Session{}, params)

    refute changeset.valid?
  end

  test "create_changeset with valid attributes" do
    params = params_for(:session)
    changeset = Session.create_changeset(%Session{}, params)

    assert changeset.changes.token
    assert changeset.valid?
  end

  test "create_changeset with invalid attributes" do
    params = %{}
    changeset = Session.create_changeset(%Session{}, params)

    refute changeset.valid?
  end
end
