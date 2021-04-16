defmodule ApiBank.Users.Create do
  alias ApiBank.Repo
  alias ApiBank.User

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
  end
end
