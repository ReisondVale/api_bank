defmodule ApiBankWeb.AccountsController do
  use ApiBankWeb, :controller

  action_fallback ApiBankWeb.FallbackController

  def withdraw(conn, params) do
    with {:ok, %{user: user}} <- ApiBank.withdraw(params) do
      conn
      |> put_status(:ok)
      |> render("withdraw.json", user: user)
    end
  end

  def deposit(conn, params) do
    with {:ok, %{user: user}} <- ApiBank.deposit(params) do
      conn
      |> put_status(:ok)
      |> render("deposit.json", user: user)
    end
  end

  def transaction(conn, params) do
    with {:ok, %{user: user}} <- ApiBank.transaction(params) do
      conn
      |> put_status(:ok)
      |> render("transaction.json", user: user)
    end
  end
end
