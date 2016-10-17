defmodule Slowmonster.Factory do
  use ExMachina.Ecto, repo: Slowmonster.Repo

  def user_factory do
    %Slowmonster.User{
      email: sequence(:email, &"email-#{&1}@example.com"),
      password: "passit",
    }
  end
end
