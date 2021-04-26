defmodule ApiBank.UserTest do
  use ApiBank.DataCase

  alias ApiBank.User

  describe "changeset/1" do
    test "create a valid changeset with a valid params" do
      assert ApiBank.Repo.all(User) == []

      params = %{
        name: "cesar",
        age: 29,
        email: "reison2@email.com",
        password_hash: "123456",
        balance: 123
      }

      assert %Ecto.Changeset{
               valid?: true,
               changes: %{
                 name: "cesar",
                 age: 29,
                 email: "reison2@email.com",
                 password_hash: "123456",
                 balance: 123
               }
             } = User.changeset(params)
    end

    test "when is an invalid age, return an error" do
      assert ApiBank.Repo.all(User) == []

      params = %{
        name: "cesar",
        age: 17,
        email: "reison2@email.com",
        password_hash: "123456",
        balance: 123
      }

      assert %Ecto.Changeset{
               valid?: false,
               changes: _,
               errors: [age: {"must be greater than or equal to %{number}", _any}]
             } = User.changeset(params)
    end

    test "when is an invalid email, return an error" do
      assert ApiBank.Repo.all(User) == []

      params = %{
        name: "cesar",
        age: 18,
        email: "reisonemail.com",
        password_hash: "123456",
        balance: 123
      }

      assert %Ecto.Changeset{
               valid?: false,
               changes: _,
               errors: [email: {"has invalid format", _any}]
             } = User.changeset(params)
    end

    test "when is an invalid password, return an error" do
      assert ApiBank.Repo.all(User) == []

      params = %{
        name: "cesar",
        age: 18,
        email: "reison@email.com",
        password_hash: "12345",
        balance: 123
      }

      assert %Ecto.Changeset{
               valid?: false,
               changes: _,
               errors: [password_hash: {"should be at least %{count} character(s)", _any}]
             } = User.changeset(params)
    end

    test "when is an negative balance, return an error" do
      assert ApiBank.Repo.all(User) == []

      params = %{
        name: "cesar",
        age: 18,
        email: "reison@email.com",
        password_hash: "123456",
        balance: -1
      }

      assert %Ecto.Changeset{
               valid?: false,
               changes: _,
               errors: [balance: {"must be greater than or equal to %{number}", _any}]
             } = User.changeset(params)
    end
  end
end
