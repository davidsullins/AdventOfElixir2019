defmodule Day5 do
  @moduledoc """
  advent of code day 5: Intcode extensions, diagnostic program
  """

  def day5 do
    input = String.trim_trailing(File.read!("_input/input5.txt"))
    {_, outputs} = IntCode.exec_intcode(input, [1])

    IO.puts(["Day5 part 1 outputs: ", Enum.join(outputs, ", ")])
  end
end
