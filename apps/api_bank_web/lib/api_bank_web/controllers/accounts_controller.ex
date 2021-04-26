defmodule ApiBankWeb.AccountsController do
  use ApiBankWeb, :controller

  action_fallback ApiBankWeb.FallbackController

  def withdraw(conn, params) do
    with {:ok, user} <- ApiBank.withdraw(params) do
      conn
      |> put_status(:ok)
      |> render("update.json", user: user)
    end
  end

  def deposit(conn, params) do
    with {:ok, user} <- ApiBank.deposit(params) do
      conn
      |> put_status(:ok)
      |> render("update.json", user: user)
    end
  end

  def transaction(conn, params) do
    with {:ok, result} <- ApiBank.transaction(params) do
      conn
      |> put_status(:ok)
      |> render("transaction.json", result: result)
    end
  end
end
