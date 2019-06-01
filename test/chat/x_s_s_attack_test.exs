defmodule Chat.XSSAttackTest do
  use ExUnit.Case

  alias Chat.XSSAttack

  @moduletag :capture_log

  doctest XSSAttack

  test "module exists" do
    assert is_list(XSSAttack.module_info())
  end

  test "xss string convert" do
    assert XSSAttack.xss_string_convert("<>\"'") == "&lt;&gt;&quot;&#39;"
    assert XSSAttack.xss_string_convert("<script>someFunctionCall(\"a\", 'b')</script>")
           == "&lt;script&gt;someFunctionCall(&quot;a&quot;, &#39;b&#39;)&lt;/script&gt;"
    assert XSSAttack.xss_string_convert("<<script>someFunctionCall(\"a\", 'b')</script>>")
           == "&lt;&lt;script&gt;someFunctionCall(&quot;a&quot;, &#39;b&#39;)&lt;/script&gt;&gt;"
  end

end
