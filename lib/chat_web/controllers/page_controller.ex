defmodule ChatWeb.PageController do
  use ChatWeb, :controller

  def index(conn, _params) do
    case get_session(conn, :name) do
       name -> redirect(conn, to: "/chat")
       nil -> redirect(conn, to: "/login")
    end
  end

end
