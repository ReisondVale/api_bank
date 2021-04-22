defmodule ApiBankWeb.Router do
  use ApiBankWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ApiBankWeb do
    pipe_through :api

    post "/users", UsersController, :create

    post "/users/:id/withdraw", AccountsController, :withdraw
    post "/users/:id/deposit", AccountsController, :deposit
    post "/users/transaction", AccountsController, :transaction
  end
end
