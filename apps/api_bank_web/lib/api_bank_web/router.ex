defmodule ApiBankWeb.Router do
  use ApiBankWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ApiBankWeb do
    pipe_through :api

    post "/users", UsersController, :create

    post "/accounts/:id/withdraw", AccountsController, :withdraw
    post "/accounts/:id/deposit", AccountsController, :deposit
  end
end
