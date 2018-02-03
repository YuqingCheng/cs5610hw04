defmodule Calc do
  def eval(line) do
    list = String.split(line, " ")
    vals = %{:toadd => 0.0, :totimes => 1.0, :func => fn x, y -> x * y end}
    map = %{:vals => vals, :list => list, :stack => []}
    eval_list(map)
  end

  def main do
    read()
  end

  defp read do
    input = IO.gets("> ")
    str = String.slice(input, 0, String.length(input)-1)
    IO.puts eval(str)
    read()
  end

  defp eval_list(map) do
    [h1 | t1] = map.list
    func = map.vals.func
    toadd = map.vals.toadd
    totimes = map.vals.totimes
    new_vals = %{:toadd => 0.0, :totimes => 1.0, :func => fn x, y -> x * y end}

    cond do
      is_open_paren h1 ->
        temp = String.slice(h1, 1, String.length(h1))
        eval_list %{:vals => new_vals, :list => [temp] ++ t1, :stack => [map.vals] ++ map.stack} 

      is_close_paren h1 ->
        if length(map.stack) == 0 do
          wrong_input()
        else
          temp = String.slice(h1, 0, String.length(h1)-1)
          [pop | stack] = map.stack
          {num, remain} = Float.parse(temp)
          head = func.(totimes, num) + toadd

          eval_list %{:vals => pop, :list => [Float.to_string(head) <> remain] ++ t1, :stack => stack}
        end
        
      true ->
        num = parse(h1)
        if length(t1) == 0 do
          if length(map.stack) > 0 do
            wrong_input()
          else
            func.(totimes, num) + toadd
          end
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

  defp is_open_paren(head) do
    if is_float(head) do
      false
    else 
      head =~ ~r/^\(/
    end
  end

  defp is_close_paren(head) do
    if is_float(head) do
      false
    else 
      head =~ ~r/\)$/
    end
  end

  defp parse num do
    if is_float(num) do
      num
    else
      Float.parse(num) |> elem(0)
    end
  end

  defp wrong_input do
    "wrong input"
  end
end
