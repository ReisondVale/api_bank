defmodule ApiBank.Accounts.Transaction do
  alias Ecto.Multi

  alias ApiBank.User
  alias ApiBank.Repo

  def call(%{"from" => from_id, "to" => to_id, "value" => value}) do

    case Multi.new()
      |> Multi.run(:from_account, fn _repo, _changes -> ApiBank.get_user(%{"id" => from_id}) end)
      |> Multi.run(:to_account, fn _repo, _changes -> ApiBank.get_user(%{"id" => to_id}) end)
      |> Multi.run(:from_account_new_balance, fn _repo, %{from_account: %{balance: balance} = from_account} ->
        case from_account
          |> User.balance_update_changeset(%{balance: balance - value})
          |> Repo.update
        do
          {:ok, user} -> {:ok, Map.fetch!(user, :balance)}
          error -> error
        end
      end)
      |> Multi.run(:to_account_new_balance, fn _repo, %{to_account: %{balance: balance} = to_account} ->
        case to_account
          |> User.balance_update_changeset(%{balance: balance + value})
          |> Repo.update
        do
          {:ok, user} -> {:ok, Map.fetch!(user, :balance)}
          error -> error
        end
      end)
      |> Repo.transaction()
    do
      {:ok, result} -> {:ok, result}
      {:error, _at, changeset, _value } -> {:error, changeset}
    end
  end
end
