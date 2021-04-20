defmodule ApiBank do
  alias ApiBank.Users.Create, as: UserCreate

  alias ApiBank.Accounts.Withdraw
  alias ApiBank.Accounts.Deposit

  defdelegate create_user(params), to: UserCreate, as: :call

  defdelegate withdraw(params), to: Withdraw, as: :call
  defdelegate deposit(params), to: Deposit, as: :call
end
