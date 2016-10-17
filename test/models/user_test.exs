defmodule Slowmonster.UserTest do
  use Slowmonster.ModelCase

  alias Slowmonster.User

  test "changeset with valid attributes" do
    params = params_for(:user)
    changeset = User.changeset(%User{}, params)

    assert changeset.valid?
  end

  test "changeset, email too short" do
    params = params_for(:user, email: "")
    changeset = User.changeset(%User{}, params)

    refute changeset.valid?
  end

  test "changeset, email invalid format" do
    params = params_for(:user, email: "foo.com")
    changeset = User.changeset(%User{}, params)

    refute changeset.valid?
  end

  test "registration_changeset, valid attributes" do
    params = params_for(:user)
    changeset = User.registration_changeset(%User{}, params)

    assert changeset.changes.password_hash
    assert changeset.valid?
  end

  test "registration_changeset, password too short" do
    params = params_for(:user, password: "aa")
    changeset = User.registration_changeset(%User{}, params)

    refute changeset.valid?
  end
end
