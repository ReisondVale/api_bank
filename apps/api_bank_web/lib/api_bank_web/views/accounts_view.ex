defmodule ApiBank.AccountsView do
  alias ApiBank.User

  def render("update.json", %{user: %User{id: user_id, balance: balance}}) do
    %{
      message: "Ballance changed successfully",
      id: user_id,
      balance: balance
    }
  end

  def transaction("update.json", %{result: %{from_account_new_balance: from_account_new_balance}}) do
    %{
      message: "Ballance changed successfully",
      balance: from_account_new_balance
    }
  end
end
