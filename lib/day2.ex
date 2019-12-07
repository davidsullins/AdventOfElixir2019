defmodule Day2 do
  @moduledoc """
  advent of code day 2: Intcode interpreter
  We use a tuple to represent Intcode memory because Elixir has no
  built-in concept of an array. A tuple has constant time element access
  but linear time modification because a shallow copy is made
  """

  def day2 do
    input = String.trim_trailing(File.read!("_input/input2.txt"))
    mem = parse_input(input)

    # "before running the program, replace position 1 with the value 12 and replace position 2 with the value 2"
    restored_mem = put_elem(put_elem(mem, 1, 12), 2, 2)
    final_mem = exec_intcode_r({0, restored_mem})
    output = elem(final_mem, 0)

    IO.puts("part 1: mem position 0 #{output}")
  end

  def parse_input(str) do
    # converts a string like "1,2,3" into a tuple like {1,2,3}
    str
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
    |> List.to_tuple()
  end

  def exec_intcode(str) do
    # return final memory value (as a tuple)
    # store program state as a tuple of the current program counter and memory value
    state = {0, parse_input(str)}
    exec_intcode_r(state)
  end

  def pc_from_state(state) do
    # program counter is first element of state tuple
    elem(state, 0)
  end

  def mem_from_state(state) do
    # memory value is second element of state tuple
    elem(state, 1)
  end

  def exec_intcode_r(state) do
    pc = pc_from_state(state)
    mem = mem_from_state(state)
    opcode = elem(mem, pc)

    case opcode do
      1 ->
        # add 2 values
        src_addr1 = elem(mem, pc + 1)
        src_addr2 = elem(mem, pc + 2)
        dest_addr = elem(mem, pc + 3)
        result = elem(mem, src_addr1) + elem(mem, src_addr2)
        new_mem = put_elem(mem, dest_addr, result)

        new_state = {pc + 4, new_mem}
        exec_intcode_r(new_state)

      2 ->
        # multiply 2 values
        src_addr1 = elem(mem, pc + 1)
        src_addr2 = elem(mem, pc + 2)
        dest_addr = elem(mem, pc + 3)
        result = elem(mem, src_addr1) * elem(mem, src_addr2)
        new_mem = put_elem(mem, dest_addr, result)

        new_state = {pc + 4, new_mem}
        exec_intcode_r(new_state)

      99 ->
        # halt execution, just return final memory values
        mem
    end
  end
end
