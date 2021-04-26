defmodule ApiBankWeb.FallbackController do
  use ApiBankWeb, :controller

  def call(conn, {:error, result}) do
    conn
    |> put_status(:bad_request)
    |> put_view(ApiBankWeb.ErrorView)
    |> render("400.json", result: result)
  end
end
