defmodule Slowmonster.Factory do
  use ExMachina.Ecto, repo: Slowmonster.Repo

  def session_factory do
    %Slowmonster.Session{
      user_id: insert(:user).id
    }
  end

  def trackable_factory do
    %Slowmonster.Trackable{
      content: "pretty good",
      user_id: insert(:user).id,
      days_in_week: 5.0,
    }
  end

  def user_factory do
    %Slowmonster.User{
      email: sequence(:email, &"email-#{&1}@example.com"),
      password: "passit",
    }
  end
end
