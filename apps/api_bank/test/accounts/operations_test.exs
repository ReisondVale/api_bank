defmodule ApiBank.Accounts.OperationTest do
  use ApiBank.DataCase

  alias ApiBank.Repo
  alias ApiBank.User
  alias ApiBank.Accounts.Operation

  describe "call/2" do
    setup do
      user =
        Repo.insert!(%User{
          name: "cesar",
          age: 29,
          email: "reison2@email.com",
          password_hash: "123456",
          balance: 100000
        })

        {:ok, id: user.id}
    end

    test "when params is valid, return a success", ctx do
      id = ctx.id
      params = %{"id" => id, "value" => 1000}

      assert {:ok,
              %User{
                name: "cesar",
                id: ^id,
                age: 29,
                email: "reison2@email.com",
                password_hash: "123456",
                balance: 99000
              }} = Operation.call(params, :withdraw)
    end

    test "when an account has an insufficient balance, returns an error in update_user", ctx do
      params = %{"id" => ctx.id, "value" => 100001}

      assert {:error,
      %Ecto.Changeset{
        errors: [balance: {"must be greater than or equal to %{number}", _any}]
      }} = Operation.call(params, :withdraw)
    end

    test "when invalid id, return error in get_user" do
      params = %{"id" => "#{Ecto.UUID.generate()}", "value" => 1000}

      assert {:error, :user_not_found} = Operation.call(params, :withdraw)
    end

  end

end
