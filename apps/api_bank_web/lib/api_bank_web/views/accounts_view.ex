defmodule ApiBank.AccountsView do
  alias ApiBank.User

  def render("update.json", %{user: %User{id: user_id, balance: balance}}) do
    %{
      message: "Ballance chand=ged successfully",
      id: user_id,
      balance: balance
    }
  end
end
