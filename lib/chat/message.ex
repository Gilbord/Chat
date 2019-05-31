defmodule Chat.Message do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias Chat.Message
  alias Chat.Repo

  schema "messages" do
    field :message, :string
    field :user_name, :string

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:user_name, :message])
    |> validate_required([:user_name, :message])
  end

  def insert_and_get(message, user_name, limit) do
    Repo.insert %Message{message: message, user_name: user_name}
    get(limit)
  end

  def get(limit) do
    Message
    |> limit(^limit)
    |> Repo.all()
  end

end
