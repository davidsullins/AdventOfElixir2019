defmodule IntCodeState do
  @moduledoc """
  Intcode machine state
  We use a tuple to represent Intcode memory because Elixir has no
  built-in concept of an array. A tuple has constant time element access
  but linear time modification because a shallow copy is made.
  Erlang's :array is a possible alternative if modification time becomes an issue
  """
  @enforce_keys [:mem]
  defstruct pc: 0, mem: {}

  @doc """
  Create an IntCodeState from a string. PC is set to 0 and mem is parsed from string
  """
  def from_str(str) do
    # converts a string like "1,2,3" into a tuple like {1,2,3}
    mem =
      str
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)
      |> List.to_tuple()

    %IntCodeState{mem: mem}
  end
end

defmodule IntCode do
  @moduledoc """
  Intcode interpreter
  """

  def exec_intcode(str) do
    # return final memory value (as a tuple)
    # store program state as a tuple of the current program counter and memory value
    state = IntCodeState.from_str(str)
    # state = {0, parse_input(str)}
    exec_intcode_r(state)
  end

  @spec exec_intcode_r(%IntCodeState{}) :: tuple
  def exec_intcode_r(state) do
    pc = state.pc
    mem = state.mem
    instruction = elem(mem, pc)
    # opcode is last 2 digits of instruction
    opcode = rem(instruction, 100)
    # parameter mode is everything left of last 2 digits
    parameter_mode = div(instruction, 100)

    case opcode do
      1 ->
        # add 2 values
        src_addr1 = elem(mem, pc + 1)
        src_addr2 = elem(mem, pc + 2)
        dest_addr = elem(mem, pc + 3)
        result = elem(mem, src_addr1) + elem(mem, src_addr2)
        new_mem = put_elem(mem, dest_addr, result)

        new_state = %IntCodeState{pc: pc + 4, mem: new_mem}
        exec_intcode_r(new_state)

      2 ->
        # multiply 2 values
        src_addr1 = elem(mem, pc + 1)
        src_addr2 = elem(mem, pc + 2)
        dest_addr = elem(mem, pc + 3)
        result = elem(mem, src_addr1) * elem(mem, src_addr2)
        new_mem = put_elem(mem, dest_addr, result)

        new_state = %IntCodeState{pc: pc + 4, mem: new_mem}
        exec_intcode_r(new_state)

      99 ->
        # halt execution, just return final memory values
        mem
    end
  end
end
