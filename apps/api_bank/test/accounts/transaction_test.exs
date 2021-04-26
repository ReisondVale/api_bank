defmodule ApiBank.Accounts.TransactionTest do
  use ApiBank.DataCase

  alias ApiBank.Repo
  alias ApiBank.User
  alias ApiBank.Accounts.Transaction

  describe "call/1" do
    setup do
      from_account =
        Repo.insert!(%User{
          name: "Reison",
          age: 29,
          email: "reison@email.com",
          password_hash: "123456"
        })

      to_account =
        Repo.insert!(%User{
          name: "Cesar",
          age: 29,
          email: "cesar@email.com",
          password_hash: "123456",
          balance: 0
        })

      {:ok, from_account: from_account.id, to_account: to_account.id}
    end

    test "when params is valid, return a success", ctx do
      from_id = ctx.from_account
      to_id = ctx.to_account
      params = %{"from" => from_id, "to" => to_id, "value" => 50000}

      assert {
               :ok,
               %{
                 from_account: %User{
                   balance: 100_000,
                   id: ^from_id,
                   name: "Reison",
                   email: "reison@email.com"
                 },
                 from_account_new_balance: 50000,
                 to_account: %User{
                   balance: 0,
                   email: "cesar@email.com",
                   id: ^to_id,
                   name: "Cesar"
                 },
                 to_account_new_balance: 50000
               }
             } = Transaction.call(params)
    end

    test "when from id are invalid, return error", ctx do
      to_id = ctx.to_account
      params = %{
        "from" => "#{Ecto.UUID.generate()}",
        "to" => to_id,
        "value" => 100
      }

      assert {:error, "User not found"} = Transaction.call(params)
    end

    test "when to id are invalid, return error", ctx do
      from_id = ctx.from_account
      params = %{
        "from" => from_id,
        "to" => "#{Ecto.UUID.generate()}",
        "value" => 100
      }

      assert {:error, "User not found"} = Transaction.call(params)
    end

    test "when an account has an insufficient balance, returns insufficient funds", ctx do
      from_id = ctx.to_account
      to_id = ctx.from_account
      params = %{"from" => from_id, "to" => to_id, "value" => 50_000}

      assert {:error,
      %Ecto.Changeset{
        errors: [balance: {"Insufficient funds", _any}]
      }} = Transaction.call(params)
    end

  end
end
