defmodule ChatWeb.ChatView do
  use ChatWeb, :view

  def render("scripts.html", _assigns) do
    ~s{<script src="/js/chat.js"></script>}
    |> raw
  end

  def render("css", _assigns) do
    ~E(<link rel="stylesheet" type="text/css" href="/css/chat.css">)
  end

end
