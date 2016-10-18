defmodule Slowmonster.TrackableControllerTest do
  use Slowmonster.ConnCase

  alias Slowmonster.Trackable
  @valid_attrs %{closed_at: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, content: "some content", days_in_week: "120.5", priority: 42}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, trackable_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    trackable = Repo.insert! %Trackable{}
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
    conn = post conn, trackable_path(conn, :create), trackable: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Trackable, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, trackable_path(conn, :create), trackable: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    trackable = Repo.insert! %Trackable{}
    conn = put conn, trackable_path(conn, :update, trackable), trackable: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Trackable, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    trackable = Repo.insert! %Trackable{}
    conn = put conn, trackable_path(conn, :update, trackable), trackable: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    trackable = Repo.insert! %Trackable{}
    conn = delete conn, trackable_path(conn, :delete, trackable)
    assert response(conn, 204)
    refute Repo.get(Trackable, trackable.id)
  end
end
