defmodule Slowmonster.UserControllerTest do
  use Slowmonster.ConnCase

  alias Slowmonster.User

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    params = params_for(:user)
    conn = post conn, user_path(conn, :create), user: params
    body = json_response(conn, 201)

    assert body["data"]["id"]
    assert body["data"]["email"] == params.email
    refute body["data"]["password"]
    assert Repo.get_by(User, email: params.email)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    params = %{}
    count_before = Repo.aggregate(User, :count, :id)
    conn = post conn, user_path(conn, :create), user: params
    body = json_response(conn, 422)
    count_after = Repo.aggregate(User, :count, :id)

    assert body["errors"] != %{}
    assert count_before == count_after
  end
end
