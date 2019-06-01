defmodule Chat.XSSAttack do
  @moduledoc false

  def xss_string_convert(string) do
    string
    |> String.replace("<", "&lt;")
    |> String.replace(">", "&gt;")
    |> String.replace("\"", "&quot;")
    |> String.replace("'", "&#39;")
  end

end
