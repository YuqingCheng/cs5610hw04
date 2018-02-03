defmodule Calc do
  def eval(line) do
    list = String.split(line, " ")
    vals = %{:toadd => 0.0, :totimes => 1.0}
    map = %{:vals => vals, :list => list}
    eval_list(map)

  end

  defp eval_list(map) do
    [h1 | t1] = map.list

    if is_open_paren h1 do
      temp = String.slice(h1, 1, String.length(h1))
    end

    num = Float.parse(h1) |> elem(0)

    if length(t1) == 0 do
      map.vals.totimes * num + map.vals.toadd
    else
      [h2 | t2] = t1
      eval_list %{:vals => eval_operator(h2, map.vals, num), :list => t2}
    end
  end

  defp eval_operator(op, vals, num) do
    toadd = vals.toadd
    totimes = vals.totimes
    case op do
      "+" -> %{:toadd => totimes * num + toadd, :totimes => 1}
      "-" -> %{:toadd => totimes * num + toadd, :totimes => -1}
      "*" -> %{:toadd => toadd, :totimes => totimes * num}
      "/" -> %{:toadd => toadd, :totimes => totimes / num}
    end
  end

  defp eval_list_by_close_paren(list) do
    
  end

  def is_open_paren(head) do
    head =~ ~r/^\([1-9][0-9]*$/ || head =~ ~r/^\(0$/
  end
end
