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

defmodule Opcode do
  @moduledoc """
  Information about how to handle an opcode's parameters
  If an opcode has 3 parameters, the first 2 are source parameters and the 3rd is a destination:
  %Opcode{source_parameter_count: 2, parameter_count: 3}
  Assumption is that source parameters always come first
  """
  @enforce_keys [:parameter_count]
  defstruct source_parameter_count: 0, parameter_count: 0
end

defmodule IntCode do
  @moduledoc """
  Intcode interpreter
  """

  @opcodes %{
    # add
    1 => %Opcode{source_parameter_count: 2, parameter_count: 3},
    # mul
    2 => %Opcode{source_parameter_count: 2, parameter_count: 3},
    # halt
    99 => %Opcode{parameter_count: 0}
  }

  def exec_intcode(str) do
    # return final memory value
    state = IntCodeState.from_str(str)
    exec_intcode_r(state)
  end

  def read_parameters(state, opcode, parameter_mode) do
    parameter_count = @opcodes[opcode].parameter_count
    source_parameter_count = @opcodes[opcode].source_parameter_count
    parameters = read_parameters_r(state, parameter_count)
    apply_parameter_mode(parameters, source_parameter_count, parameter_mode, state.mem)
  end

  @doc """
  apply parameter mode to source parameters
  position mode: parameter represents a position in memory that the value should be read from
  immediate mode: parameter represents an immediate value
  """
  def apply_parameter_mode(parameters, source_parameter_count, parameter_mode, mem) do
    cond do
      source_parameter_count == 0 ->
        # no remaining source parameters so leave them unchanged
        parameters

      rem(parameter_mode, 10) == 0 ->
        # position mode: look up value from memory
        [
          elem(mem, hd(parameters))
          | apply_parameter_mode(
              tl(parameters),
              source_parameter_count - 1,
              div(parameter_mode, 10),
              mem
            )
        ]

      rem(parameter_mode, 10) == 1 ->
        # immediate mode: use value directly
        [
          hd(parameters)
          | apply_parameter_mode(
              tl(parameters),
              source_parameter_count - 1,
              div(parameter_mode, 10),
              mem
            )
        ]
    end
  end

  @doc """
  read the parameters directly from memory
  before applying parameter mode
  """
  def read_parameters_r(state, parameter_count) do
    if parameter_count < 1 do
      []
    else
      # note: appending a list like this is slow
      read_parameters_r(state, parameter_count - 1) ++
        [elem(state.mem, state.pc + parameter_count)]
    end
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

    parameters = read_parameters(state, opcode, parameter_mode)

    case opcode do
      1 ->
        # add 2 values
        [src1, src2, dest_addr] = parameters
        result = src1 + src2
        new_mem = put_elem(mem, dest_addr, result)

        new_state = %IntCodeState{pc: pc + 4, mem: new_mem}
        exec_intcode_r(new_state)

      2 ->
        # multiply 2 values
        [src1, src2, dest_addr] = parameters
        result = src1 * src2
        new_mem = put_elem(mem, dest_addr, result)

        new_state = %IntCodeState{pc: pc + 4, mem: new_mem}
        exec_intcode_r(new_state)

      99 ->
        # halt execution, just return final memory values
        mem
    end
  end
end
