defmodule ApiBank.UserTest do
  use ApiBank.DataCase

  alias ApiBank.User

  describe "changeset/1" do
    test "create a valid changeset with a valid params" do
      assert ApiBank.Repo.all(User) == []
      params = %{name: "cesar", age: 29, email: "reison2@email.com", password_hash: "123456", balance: 123}

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
  end
end
