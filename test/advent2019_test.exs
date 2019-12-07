defmodule Advent2019Test do
  @moduledoc false
  use ExUnit.Case

  test "day 1 part 1" do
    assert Day1.count_up_fuel(12) == 2
    assert Day1.count_up_fuel(14) == 2
    assert Day1.count_up_fuel(1969) == 654
    assert Day1.count_up_fuel(100_756) == 33_583
  end

  test "day 1 part 2" do
    assert Day1.count_up_fuel2(12) == 2
    assert Day1.count_up_fuel2(14) == 2
    assert Day1.count_up_fuel2(1969) == 966
    assert Day1.count_up_fuel2(100_756) == 50_346
  end
end
