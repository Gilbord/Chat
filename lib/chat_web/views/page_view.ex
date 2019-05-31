defmodule ChatWeb.PageView do
  use ChatWeb, :view

  def render("scripts.html", _assigns) do
    ~s{<script src="/js/login.js"></script>}
    |> raw
  end

end
