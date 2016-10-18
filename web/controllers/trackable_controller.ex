defmodule Slowmonster.TrackableController do
  use Slowmonster.Web, :controller

  alias Slowmonster.Trackable

  def index(conn, _params) do
    trackables = Repo.all(Trackable)
    render(conn, "index.json", trackables: trackables)
  end

  def create(conn, %{"trackable" => trackable_params}) do
    changeset = Trackable.changeset(%Trackable{}, trackable_params)

    case Repo.insert(changeset) do
      {:ok, trackable} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", trackable_path(conn, :show, trackable))
        |> render("show.json", trackable: trackable)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Slowmonster.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    trackable = Repo.get!(Trackable, id)
    render(conn, "show.json", trackable: trackable)
  end

  def update(conn, %{"id" => id, "trackable" => trackable_params}) do
    trackable = Repo.get!(Trackable, id)
    changeset = Trackable.changeset(trackable, trackable_params)

    case Repo.update(changeset) do
      {:ok, trackable} ->
        render(conn, "show.json", trackable: trackable)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Slowmonster.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    trackable = Repo.get!(Trackable, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(trackable)

    send_resp(conn, :no_content, "")
  end
end
