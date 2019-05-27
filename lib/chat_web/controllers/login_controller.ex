defmodule ChatWeb.LoginController do
  use ChatWeb, :controller

  def index(conn, _params) do
    render(conn, "login.html")
  end

  def create(conn, %{"userName" => userName}) do
    conn = put_session(conn, :userName, userName)
    redirect(conn, to: "/chat")
  end

end
