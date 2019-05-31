defmodule ChatWeb.RoomChannel do

  use Phoenix.Channel
  alias Chat.Application

  def join("room:lobby", _message, socket) do
    send(self(), :after_join)
    {:ok, socket}
  end

  def join("room:" <> _private_room_id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_in("new_msg", %{"body" => body}, socket) do
    user_name = socket.assigns.current_user
    Application.insert(body, user_name)
    broadcast!(socket, "new_msg", %{body: body, userName: user_name})
    {:noreply, socket}
  end

  def handle_in("leave", _params, socket) do
    broadcast!(socket, "system_event", %{body: "#{socket.assigns.current_user} is offline."})
    {:noreply, socket}
  end

  def handle_info(:after_join, socket) do
    broadcast!(socket, "system_event", %{body: "#{socket.assigns.current_user} is online."})
    {:noreply, socket}
  end

end
