defmodule ApiBank.Accounts.Transactions.Response do
  alias ApiBank.User

  defstruct [:from_user, :to_user]

  def build(%User{} = from_user, %User{} = to_user) do
    %__MODULE__{
      from_user: from_user,
      to_user: to_user
    }
  end
end
