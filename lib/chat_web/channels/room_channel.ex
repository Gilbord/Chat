defmodule ChatWeb.RoomChannel do

  use Phoenix.Channel
  alias Chat.Application
  alias Chat.XSSAttack
  require Logger

  def join("room:lobby", _message, socket) do
    send(self(), :after_join)
    {:ok, socket}
  end

  def join("room:" <> _private_room_id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_in("new_msg", %{"body" => body}, socket) do
    user_name = socket.assigns.current_user
    message = XSSAttack.xss_string_convert(body)
    Application.insert(message, user_name)
    broadcast!(socket, "new_msg", %{body: message, userName: user_name})
    {:noreply, socket}
  end

  def handle_info(:after_join, socket) do
    broadcast!(socket, "system_event", %{body: "#{socket.assigns.current_user} is online."})
    {:noreply, socket}
  end

end
