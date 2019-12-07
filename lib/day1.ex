defmodule Day1 do
  @moduledoc """
  advent of code day 1: fuel requirements
  """
  def count_up_fuel(mass) do
    div(mass, 3) - 2
  end
end
