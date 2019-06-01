defmodule ChatWeb.ChatController do
  use ChatWeb, :controller
  alias Chat.Application
  require Logger

  def index(conn, _params) do
    messages = Application.get()
    case get_session(conn, :user_name) do
      nil -> redirect(conn, to: "/")
      user_name -> render(put_secure_browser_headers(conn), "chat.html",  user_name: user_name, messages: messages)
    end
  end

  def create(conn, %{"user_name" => user_name}) do
    json(put_session(conn, :user_name, user_name), %{message: "ok"})
  end

end
