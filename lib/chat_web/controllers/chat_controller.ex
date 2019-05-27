defmodule ChatWeb.ChatController do
  use ChatWeb, :controller

  def index(conn, _params) do
    render(conn, "chat.html",  userName: get_session(conn, :userName), messages: [])
  end

  def create(conn, %{"name" => name}) do
    conn = put_session(conn, :name, name)
    render(conn, "chat.html", name: name)
  end

end
