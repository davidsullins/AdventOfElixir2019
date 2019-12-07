defmodule Day1 do
  @moduledoc """
  advent of code day 1: fuel requirements
  """
  def day1 do
    output = parse_file("_input/input1.txt")
    IO.puts("part 1: Total fuel required #{output}")
  end

  def count_up_fuel(mass) do
    div(mass, 3) - 2
  end

  def parse_file(filename) do
    File.stream!(filename)
    |> Stream.map(&String.trim_trailing/1)
    |> Stream.map(&String.to_integer/1)
    |> Stream.map(&Day1.count_up_fuel/1)
    |> Enum.sum()
  end

  # part 2
  def count_up_fuel2(mass) do
    fuel = count_up_fuel(mass)

    if fuel > 0 do
      # take fuel needed to transport fuel into account
      fuel + count_up_fuel2(fuel)
    else
      0
    end
  end
end
