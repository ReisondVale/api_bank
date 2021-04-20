defmodule ApiBank.Accounts.Withdraw do
  alias ApiBank.Accounts.Operation

  def call(params) do
    params
    |> Operation.call(:withdraw)
  end
end
