defmodule Calc do
  def eval(line) do
    list = String.split(line, " ")
    vals = %{:toadd => 0.0, :totimes => 1.0, :func => fn x, y -> x * y end}
    map = %{:vals => vals, :list => list, :stack => []}
    eval_list(map)
  end

  defp eval_list(map) do
    [h1 | t1] = map.list
    func = map.vals.func
    toadd = map.vals.toadd
    totimes = map.vals.totimes
    new_vals = %{:toadd => 0.0, :totimes => 1.0, :func => fn x, y -> x * y end}

    cond do
      is_open_paren(h1) && is_close_paren(h1) ->
        temp = String.slice(h1, 1, String.length(h1)-1)
        eval_list %{map | :list => [temp] ++ t1}
      is_open_paren h1 ->
        temp = String.slice(h1, 1, String.length(h1))
        eval_list %{:vals => new_vals, :list => [temp] ++ t1, :stack => [map.vals] ++ map.stack} 
      is_close_paren h1 ->
        temp = String.slice(h1, 0, String.length(h1)-1)
        [pop | stack] = map.stack
        tuple = Float.parse(temp)
        num = elem(tuple, 0)
        remain = elem(tuple, 1)

        head = pop.func.(pop.totimes, func.(totimes, num) + toadd) + pop.toadd
        eval_list %{:vals => new_vals, :list => [Float.to_string(head) <> remain] ++ t1, :stack => stack}
      true ->
        num = parse(h1)
        if length(t1) == 0 do
          func.(totimes, num) + toadd
        else
          [h2 | t2] = t1
          eval_list %{:vals => eval_operator(h2, map.vals, num), :list => t2, :stack => map.stack}
        end
    end    
  end

  defp eval_operator(op, vals, num) do
    toadd = vals.toadd
    totimes = vals.totimes
    func = vals.func
    case op do
      "+" -> %{:toadd => func.(totimes, num) + toadd, :totimes => 1, :func => fn x, y -> x*y end}
      "-" -> %{:toadd => func.(totimes, num) + toadd, :totimes => -1, :func => fn x, y -> x*y end}
      "*" -> %{:toadd => toadd, :totimes => func.(totimes, num), :func => fn x, y -> x*y end}
      "/" -> %{:toadd => toadd, :totimes => func.(totimes, num), :func => fn x, y -> x/y end}
    end
  end

  def is_open_paren(head) do
    if is_float(head) do
      false
    else 
      head =~ ~r/^\(/
    end
  end

  def is_close_paren(head) do
    if is_float(head) do
      false
    else 
      head =~ ~r/\)$/
    end
  end

  def parse num do
    if is_float(num) do
      num
    else
      Float.parse(num) |> elem(0)
    end
  end
end
