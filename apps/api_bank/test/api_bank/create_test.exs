defmodule ApiBank.Users.CreateTest do
  use ApiBank.DataCase

  alias ApiBank.Repo
  alias ApiBank.User
  alias ApiBank.Users.Create

  describe "call/1" do
    test "when is email is already taken, return an error" do
      Repo.insert!(%User{
        name: "cesar",
        age: 29,
        email: "reison2@email.com",
        password_hash: "123456",
        balance: 123
      })

      params = %{
        name: "cesar",
        age: 29,
        email: "reison2@email.com",
        password_hash: "123456",
        balance: 123
      }

      assert {:error,
              %Ecto.Changeset{
                valid?: false,
                changes: _,
                errors: [email: {"has already been taken", _any}]
              }} = Create.call(params)
    end
  end
end
