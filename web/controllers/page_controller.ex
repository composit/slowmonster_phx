defmodule Slowmonster.PageController do
  use Slowmonster.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
