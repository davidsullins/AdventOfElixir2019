defmodule Day2 do
  @moduledoc """
  advent of code day 2: Intcode interpreter
  We use a tuple to represent Intcode memory because Elixir has no
  built-in concept of an array. A tuple has constant time element access
  but linear time modification because a shallow copy is made
  """

  def day2 do
    input = String.trim_trailing(File.read!("_input/input2.txt"))
    state = IntCodeState.from_str(input)
    mem = state.mem

    # "before running the program, replace position 1 with the value 12 and replace position 2 with the value 2"
    restored_mem = put_elem(put_elem(mem, 1, 12), 2, 2)
    final_mem = IntCode.exec_intcode_r(%IntCodeState{pc: 0, mem: restored_mem})
    output = elem(final_mem, 0)

    IO.puts("part 1: mem position 0 #{output}")

    # part 2
    find_noun_verb(mem)
  end

  # part 2
  def find_noun_verb(mem) do
    magic_search_val = 19_690_720

    Enum.each(0..99, fn noun ->
      Enum.each(0..99, fn verb ->
        if try_noun_verb(mem, noun, verb) == magic_search_val do
          IO.puts("found noun, verb #{noun}, #{verb}")
          result = 100 * noun + verb
          IO.puts("100 * noun + verb = #{result}")
        end
      end)
    end)
  end

  def try_noun_verb(mem, noun, verb) do
    restored_mem = put_elem(put_elem(mem, 1, noun), 2, verb)
    final_mem = IntCode.exec_intcode_r(%IntCodeState{pc: 0, mem: restored_mem})
    elem(final_mem, 0)
  end
end
