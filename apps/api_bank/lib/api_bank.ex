defmodule ApiBank do
  alias ApiBank.Users.Create, as: UserCreate
  alias ApiBank.Users.Get, as: UserGet

  alias ApiBank.Accounts.Withdraw
  alias ApiBank.Accounts.Deposit
  alias ApiBank.Accounts.Transaction

  defdelegate create_user(params), to: UserCreate, as: :call

  defdelegate get_user(params), to: UserGet, as: :call

  defdelegate withdraw(params), to: Withdraw, as: :call

  defdelegate deposit(params), to: Deposit, as: :call

  defdelegate transaction(params), to: Transaction, as: :call

end
