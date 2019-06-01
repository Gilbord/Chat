defmodule ChatWeb.RoomChannelTest do

  use ExUnit.Case
  use ChatWeb.ChannelCase

  alias ChatWeb.RoomChannel
  alias ChatWeb.UserSocket
  alias Chat.Application

  @moduletag :capture_log

  doctest RoomChannel

  setup do
    Application.clear()
  end

  setup do
    {:ok, _, socket} =
      socket(UserSocket, "user_name", %{current_user: "user_name"})
      |> subscribe_and_join(RoomChannel, "room:lobby")

    {:ok, socket: socket}
  end

  test "shout broadcasts to room:lobby", %{socket: socket} do
    push(socket, "new_msg", %{body: "test"})
    assert_broadcast "system_event", %{body: "user_name is online."}
    assert_push "system_event", %{body: "user_name is online."}
    assert_broadcast "new_msg", %{body: "test", userName: "user_name"}
    assert_push "new_msg", %{body: "test", userName: "user_name"}
    assert Enum.count(Application.get()) == 1
    message = Enum.at(Application.get(), 0)
    assert message.message == "test"
    assert message.user_name == "user_name"
  end

  test "xss attack", %{socket: socket} do
    push(socket, "new_msg", %{body: "<>\"'"})
    assert_broadcast "system_event", %{body: "user_name is online."}
    assert_push "system_event", %{body: "user_name is online."}
    assert_broadcast "new_msg", %{body: "&lt;&gt;&quot;&#39;", userName: "user_name"}
    assert_push "new_msg", %{body: "&lt;&gt;&quot;&#39;", userName: "user_name"}
  end

  test "module exists" do
    assert is_list(RoomChannel.module_info())
  end



end
