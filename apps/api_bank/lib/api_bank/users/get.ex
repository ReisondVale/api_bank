defmodule ApiBank.Users.Get do
  alias ApiBank.Repo
  alias ApiBank.User

  def call(%{"id" => id}) do
    case Repo.get_by(User, id: id) do
      nil -> {:error, "User not found"}
      user -> {:ok, user}
    end
  end
end
