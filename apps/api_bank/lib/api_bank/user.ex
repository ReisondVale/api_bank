defmodule ApiBank.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params [:name, :age, :email, :password_hash]

  schema "users" do
    field :name, :string
    field :age, :integer
    field :email, :string
    field :password_hash, :string
    field :balance, :integer, default: 100_000

    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, [:name, :age, :email, :password_hash, :balance])
    |> validate_required(@required_params)
    |> validate_length(:password_hash, min: 6)
    |> validate_number(:age, greater_than_or_equal_to: 18)
    |> validate_number(:balance, greater_than_or_equal_to: 0)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint([:email])
  end
end
