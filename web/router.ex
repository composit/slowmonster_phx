defmodule Slowmonster.Router do
  use Slowmonster.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Slowmonster do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", Slowmonster do
  #   pipe_through :api
  # end

  scope "/api", Slowmonster do
    pipe_through :api

    resources "/sessions", SessionController, only: [:create]
    resources "/trackables", TrackableController, except: [:new, :edit]
    resources "/users", UserController, only: [:create]
  end
end
