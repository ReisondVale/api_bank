defmodule ApiBank.Accounts.Operation do
  alias ApiBank.Repo
  alias ApiBank.User
  alias Ecto.Multi

  import Ecto.Query

  require Logger

  def call(%{"id" => id, "value"=> value}, operation) do
    Multi.new()
    |> Multi.run(:get_user, fn repo, _changes ->
      User
      |> where([u], u.id == ^id)
      |> lock("FOR UPDATE")
      |> repo.one()
      |> case do
        nil -> {:error, :user_not_found}
        %User{} = user -> {:ok, user}
      end
    end)

    |> Multi.run(:update_user, fn repo, %{get_user: user} ->
      params = %{balance: account_operation(user, value, operation)}

      user
      |> User.changeset(params)
      |> repo.update()
    end)

    |> Multi.run(:validate_balance, fn _repo, %{update_user: user} ->
      if user.balance >= 0 do
        {:ok, user}
      else
        {:error, :not_enough_funds}
      end
    end)
    |> Repo.transaction()
    |> case do
      {:ok, %{validate_balance: user}} ->
        Logger.info("Successfully done")
        {:ok, user}

      {:error, error} ->
        Logger.error("Error in transaction", reason: inspect(error))
        {:error, error}

      {:error, step, error, _} ->
        Logger.error("Error executing transaction in #{step} step", reason: inspect(error))
        {:error, error}
    end
  end

  defp account_operation(user, value, :deposit), do: user.balance + value
  defp account_operation(user, value, :withdraw), do: user.balance - value

end
