defmodule ChatWeb.LoginView do
  use ChatWeb, :view

  def render("scripts.html", _assigns) do
    ~E(<script src="/js/login.js"></script>)
  end

end
