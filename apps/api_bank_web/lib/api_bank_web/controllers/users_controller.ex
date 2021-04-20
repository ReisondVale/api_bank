defmodule ApiBankWeb.UsersController do
  use ApiBankWeb, :controller

  alias ApiBank.User

  action_fallback ApiBankWeb.FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- ApiBank.create_user(params) do
      conn
      |> put_status(:created)
      |> render("create.json", user: user)
    end
  end
end
