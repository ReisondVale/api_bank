defmodule ApiBank.Accounts.Deposit do
  alias ApiBank.Accounts.Operation

  def call(params) do
    params
    |> Operation.call(:deposit)
  end
end
