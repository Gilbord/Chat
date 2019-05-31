defmodule Chat.PostgreSQLGenServer do
  @moduledoc false
  use GenServer
  alias Chat.PostgreSQLGenServer
  alias Chat.Message
  require Logger

  @limit 100

  # Client
  def start_link(default) when is_list(default) do
    {:ok, _pid} = GenServer.start_link(
      __MODULE__,
      [],
      name: __MODULE__
    )
  end

  def insert(message, user_name) do
    :ok = GenServer.cast(PostgreSQLGenServer, {:insert, message, user_name})
  end

  def get() do
    GenServer.call(PostgreSQLGenServer, {:get})
  end

  def clear do
    :ok = GenServer.cast(PostgreSQLGenServer, :clear)
  end

  ### Server Callbacks
  def init(_) do
    {:ok, zero_state()}
  end

  def handle_cast({:insert, message, user_name}, _state) do
    {
      :noreply,
      Message.insert_and_get(message, user_name, @limit)
    }
  end

  def handle_call({:get}, _from, state) do
    {
      :reply,
      state,
      state
    }
  end

  defp zero_state, do: Message.get(@limit)

end
