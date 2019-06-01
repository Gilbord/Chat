defmodule ChatWeb.ChatControllerTest do
  use ExUnit.Case
  use ChatWeb.ConnCase

  import Plug.Test

  alias ChatWeb.ChatController

  @moduletag :capture_log

  doctest ChatController

  test "module exists" do
    assert is_list(ChatController.module_info())
  end

  test "GET / without session", %{conn: conn} do
    conn = get(conn, "/chat")
    assert redirected_to(conn, 302) =~ "/"
  end

  test "GET / with session", %{conn: conn} do
    conn = conn
      |> assign(:user_name, "user_name")
      |> get("/chat")
    assert response_content_type(conn, :html) =~ "charset=utf-8"
  end

  test "CREATE / add session", %{conn: conn} do
    conn = init_test_session(conn, [])
    assert get_session(conn, :user_name) == nil
    conn = post(conn, "/chat", %{"user_name" => "user_name"})
    assert json_response(conn, 200) == %{"message" => "ok"}
    assert get_session(conn, :user_name) == "user_name"
  end

end
