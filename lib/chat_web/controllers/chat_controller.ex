defmodule ChatWeb.ChatController do
  use ChatWeb, :controller
  alias Chat.Application
  require Logger

  def index(conn, _params) do
    messages = Application.get()
    render(conn, "chat.html",  userName: get_session(conn, :userName), messages: messages)
  end

end
