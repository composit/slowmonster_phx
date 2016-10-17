defmodule Slowmonster.SessionControllerTest do
  use Slowmonster.ConnCase

  alias Slowmonster.Session
  alias Slowmonster.User

  @user_params params_for(:user)

  setup %{conn: conn} do
    changeset = User.registration_changeset(%User{}, @user_params)
    Repo.insert changeset
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, session_path(conn, :create), user: @user_params

    assert token = json_response(conn, 201)["data"]["token"]
    assert Repo.get_by(Session, token: token)
  end

  test "does not create resource and renders errors when password is invalid", %{conn: conn} do
    conn = post conn, session_path(conn, :create), user: Map.put(@user_params, :password, "notright")
    count_before = Repo.aggregate(Session, :count, :id)
    body = json_response(conn, 401)
    count_after = Repo.aggregate(Session, :count, :id)

    assert body["errors"] != %{}
    assert count_before == count_after
  end

  test "does not create resource and renders errors when email is invalid", %{conn: conn} do
    params = Map.put(@user_params, :email, "notright@example.com")
    conn = post conn, session_path(conn, :create), user: Map.put(@user_params, :email, "notright@example.com")
    count_before = Repo.aggregate(Session, :count, :id)
    body = json_response(conn, 401)
    count_after = Repo.aggregate(Session, :count, :id)

    assert body["errors"] != %{}
    assert count_before == count_after
  end
end
