defmodule ApiBank do
  alias ApiBank.Users.Create, as: UserCreate

  defdelegate create_user(params), to: UserCreate, as: :call
end
