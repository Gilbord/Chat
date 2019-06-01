defmodule ChatWeb.PageControllerTest do
  use ChatWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert response_content_type(conn, :html) =~ "charset=utf-8"
  end
end
