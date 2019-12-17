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

  test "day 2 part 1" do
    # intcode input parsing
    assert IntCodeState.from_str("1,2,3,4,5,37") == %IntCodeState{pc: 0, mem: {1, 2, 3, 4, 5, 37}}

    # intcode examples from problem description
    assert IntCode.exec_intcode("1,9,10,3,2,3,11,0,99,30,40,50") ==
             {{3500, 9, 10, 70, 2, 3, 11, 0, 99, 30, 40, 50}, []}

    assert IntCode.exec_intcode("1,0,0,0,99") == {{2, 0, 0, 0, 99}, []}
    assert IntCode.exec_intcode("2,3,0,3,99") == {{2, 3, 0, 6, 99}, []}
    assert IntCode.exec_intcode("2,4,4,5,99,0") == {{2, 4, 4, 5, 99, 9801}, []}
    assert IntCode.exec_intcode("1,1,1,4,99,5,6,0,99") == {{30, 1, 1, 4, 2, 5, 6, 0, 99}, []}
  end

  test "day 3 part 1" do
    # examples from problem description
    assert Day3.find_intersection_distance("R8,U5,L5,D3\nU7,R6,D4,L4") == 6

    assert Day3.find_intersection_distance(
             "R75,D30,R83,U83,L12,D49,R71,U7,L72\nU62,R66,U55,R34,D71,R55,D58,R83"
           ) == 159

    assert Day3.find_intersection_distance(
             "R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51\nU98,R91,D20,R16,D67,R40,U7,R15,U6,R7"
           ) == 135
  end

  test "day 3 part 2" do
    # examples from problem description
    assert Day3.find_intersection_path_distance("R8,U5,L5,D3\nU7,R6,D4,L4") == 30

    assert Day3.find_intersection_path_distance(
             "R75,D30,R83,U83,L12,D49,R71,U7,L72\nU62,R66,U55,R34,D71,R55,D58,R83"
           ) == 610

    assert Day3.find_intersection_path_distance(
             "R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51\nU98,R91,D20,R16,D67,R40,U7,R15,U6,R7"
           ) == 410
  end

  test "day 4 part 1" do
    # examples from problem description
    assert Day4.is_valid_password(111_111)
    refute Day4.is_valid_password(223_450)
    refute Day4.is_valid_password(123_789)
  end

  test "day 4 part 2" do
    # examples from problem description
    assert Day4.is_valid_password2(112_233)
    refute Day4.is_valid_password2(123_444)
    assert Day4.is_valid_password2(111_122)
  end

  test "day 5 part 1" do
    # intcode examples from problem description
    assert IntCode.exec_intcode("1002,4,3,4,33") == {{1002, 4, 3, 4, 99}, []}
    assert IntCode.exec_intcode("1101,100,-1,4,0") == {{1101, 100, -1, 4, 99}, []}
    assert IntCode.exec_intcode("3,0,4,0,99", [37]) == {{37, 0, 4, 0, 99}, [37]}
    # intcode tests I made up for further testing
    # test input instruction
    assert IntCode.exec_intcode("3,2,0", [99]) == {{3, 2, 99}, []}
    # test output instruction
    assert IntCode.exec_intcode("4,3,99,37", []) == {{4, 3, 99, 37}, [37]}
  end

  test "day 5 part 2" do
    # intcode examples from problem description
    # == 8 true
    assert IntCode.exec_intcode("3,9,8,9,10,9,4,9,99,-1,8", [8]) ==
             {{3, 9, 8, 9, 10, 9, 4, 9, 99, 1, 8}, [1]}

    # == 8 false
    assert IntCode.exec_intcode("3,9,8,9,10,9,4,9,99,-1,8", [7]) ==
             {{3, 9, 8, 9, 10, 9, 4, 9, 99, 0, 8}, [0]}

    # < 8 true
    assert IntCode.exec_intcode("3,9,7,9,10,9,4,9,99,-1,8", [7]) ==
             {{3, 9, 7, 9, 10, 9, 4, 9, 99, 1, 8}, [1]}

    # < 8 false
    assert IntCode.exec_intcode("3,9,7,9,10,9,4,9,99,-1,8", [8]) ==
             {{3, 9, 7, 9, 10, 9, 4, 9, 99, 0, 8}, [0]}

    # == 8 true (immediate)
    assert IntCode.exec_intcode("3,3,1108,-1,8,3,4,3,99", [8]) ==
             {{3, 3, 1108, 1, 8, 3, 4, 3, 99}, [1]}

    # == 8 false (immediate)
    assert IntCode.exec_intcode("3,3,1108,-1,8,3,4,3,99", [7]) ==
             {{3, 3, 1108, 0, 8, 3, 4, 3, 99}, [0]}

    # < 8 true (immediate)
    assert IntCode.exec_intcode("3,3,1107,-1,8,3,4,3,99", [7]) ==
             {{3, 3, 1107, 1, 8, 3, 4, 3, 99}, [1]}

    # < 8 false (immediate)
    assert IntCode.exec_intcode("3,3,1107,-1,8,3,4,3,99", [8]) ==
             {{3, 3, 1107, 0, 8, 3, 4, 3, 99}, [0]}

    # jz true, test if input is 0
    assert IntCode.exec_intcode("3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9", [0]) ==
             {{3, 12, 6, 12, 15, 1, 13, 14, 13, 4, 13, 99, 0, 0, 1, 9}, [0]}

    # jz false, test if input is 0
    assert IntCode.exec_intcode("3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9", [37]) ==
             {{3, 12, 6, 12, 15, 1, 13, 14, 13, 4, 13, 99, 37, 1, 1, 9}, [1]}

    # jnz false, test if input is not 0 (immediate)
    assert IntCode.exec_intcode("3,3,1105,-1,9,1101,0,0,12,4,12,99,1", [0]) ==
             {{3, 3, 1105, 0, 9, 1101, 0, 0, 12, 4, 12, 99, 0}, [0]}

    # jnz true, test if input is not 0 (immediate)
    assert IntCode.exec_intcode("3,3,1105,-1,9,1101,0,0,12,4,12,99,1", [37]) ==
             {{3, 3, 1105, 37, 9, 1101, 0, 0, 12, 4, 12, 99, 1}, [1]}

    # bigger program:
    # outputs 999 if input < 8
    # outputs 1000 if input == 8
    # outputs 1001 if input > 8
    intcode_str =
      "3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99"

    {_, outputs} = IntCode.exec_intcode(intcode_str, [7])
    assert outputs == [999]
    {_, outputs} = IntCode.exec_intcode(intcode_str, [8])
    assert outputs == [1000]
    {_, outputs} = IntCode.exec_intcode(intcode_str, [9])
    assert outputs == [1001]
  end
end
