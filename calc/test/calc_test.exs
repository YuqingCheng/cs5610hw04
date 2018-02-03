defmodule CalcTest do
  use ExUnit.Case

  test "1 + 1" do
    assert Calc.eval("1 + 1") == 2.0
  end

  test "4 * 7" do
    assert Calc.eval("4 * 7") == 28.0
  end

  test "4 * 7.5" do
    assert Calc.eval("4 * 7.5") == 30.0
  end

  test "3 + 4 * 7" do
    assert Calc.eval("3 + 4 * 7") == 31.0
  end

  test "1 + 1 / 2" do
    assert Calc.eval("1 + 1 / 2") == 1.5
  end

  test "4 * (1 + 2)" do
    assert Calc.eval("4 * (1 + 2)") == 12.0
  end

  test "4 * (2 + 2) / 5" do
    assert Calc.eval("4 * (2 + 2) / 5") == 3.2
  end
  test "4 - (2 + 2) / 5" do
    assert Calc.eval("4 - (2 + 2) / 5") == 3.2
  end

  test "2 - 3 * 1.5" do
    assert Calc.eval("2 - 3 * 1.5") == -2.5
  end

  test "(1)" do
    assert Calc.eval("(1)") == 1.0
  end

  test "2 + (3 * (2 + (1 + 9) * 5))" do
    assert Calc.eval("2 + (3 * (2 + (1 + 9) * 5))") == 158.0
  end

  test "3 * (1 + 1 / 2) + ((9 + 7 / (2 + 3)) * 2)" do
    assert Calc.eval("3 * (1 + 1 / 2) + ((9 + 7 / (2 + 3)) * 2)") == 25.3
  end

  test "(3 * 2 + (5 * ((1 + 2) / 2)))" do
    assert Calc.eval("(3 * 2 + (5 * ((1 + 2) / 2)))") == 13.5
  end

  test "(3 * (2 + 5 * ((1 + 2) / 2)))" do
    assert Calc.eval("(3 * (2 + 5 * ((1 + 2) / 2)))") == 28.5
  end

  test "(((1 + 3)))" do
    assert Calc.eval("(((1 + 3)))") == 4.0
  end




end
