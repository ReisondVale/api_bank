defmodule ApiBankWeb.AccountsView do
  alias ApiBank.User

  def render("update.json", %{user: %User{id: user_id, balance: balance}}) do
    %{
      message: "Successful Transaction",
      id: user_id,
      balance: balance
    }
  end

  def render("transaction.json", %{result: %{from_account: from_account, to_account: to_account, from_account_new_balance: from_account_new_balance, to_account_new_balance: to_account_new_balance}}) do
    %{
      message: "Successful Transfer",
      result: %{
        from_account: %{
          name: from_account.name,
          id: from_account.id,
          balance: from_account_new_balance
        },
        to_account: %{
          name: to_account.name,
          id: to_account.id,
          balance: to_account_new_balance
        }
      }
    }
  end
end
