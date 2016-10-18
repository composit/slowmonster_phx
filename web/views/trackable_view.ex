defmodule Slowmonster.TrackableView do
  use Slowmonster.Web, :view

  def render("index.json", %{trackables: trackables}) do
    %{data: render_many(trackables, Slowmonster.TrackableView, "trackable.json")}
  end

  def render("show.json", %{trackable: trackable}) do
    %{data: render_one(trackable, Slowmonster.TrackableView, "trackable.json")}
  end

  def render("trackable.json", %{trackable: trackable}) do
    %{id: trackable.id,
      content: trackable.content,
      user_id: trackable.user_id,
      priority: trackable.priority,
      closed_at: trackable.closed_at,
      days_in_week: trackable.days_in_week}
  end
end
