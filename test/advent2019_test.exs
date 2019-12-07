defmodule Advent2019Test do
  use ExUnit.Case
  doctest Advent2019

  test "the truth" do
    assert 1 + 1 == 2
  end

  test "day 1 part 1" do
    assert Day1.count_up_fuel(12) == 2
    assert Day1.count_up_fuel(14) == 2
    assert Day1.count_up_fuel(1969) == 654
    assert Day1.count_up_fuel(100_756) == 33_583
  end
end
