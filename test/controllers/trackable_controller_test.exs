defmodule Slowmonster.TrackableControllerTest do
  use Slowmonster.ConnCase

  alias Slowmonster.Trackable

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, trackable_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    trackable = insert(:trackable)
    conn = get conn, trackable_path(conn, :show, trackable)
    assert json_response(conn, 200)["data"] == %{"id" => trackable.id,
      "content" => trackable.content,
      "user_id" => trackable.user_id,
      "priority" => trackable.priority,
      "closed_at" => trackable.closed_at,
      "days_in_week" => trackable.days_in_week}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, trackable_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    params = params_for(:trackable)
    conn = post conn, trackable_path(conn, :create), trackable: params

    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Trackable, %{content: params.content, user_id: params.user_id})
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, trackable_path(conn, :create), trackable: %{}

    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    trackable = insert(:trackable)
    params = %{content: "pretty bad"}
    conn = put conn, trackable_path(conn, :update, trackable), trackable: params
    
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Trackable, %{content: params.content, user_id: trackable.user_id})
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    trackable = insert(:trackable)
    params = %{content: nil}
    conn = put conn, trackable_path(conn, :update, trackable), trackable: params

    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    trackable = insert(:trackable)
    conn = delete conn, trackable_path(conn, :delete, trackable)

    assert response(conn, 204)
    refute Repo.get(Trackable, trackable.id)
  end
end
