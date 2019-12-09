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
    # input parsing
    assert Day2.parse_input("1,2,3,4,5,37") == {1, 2, 3, 4, 5, 37}

    # examples from problem description
    assert Day2.exec_intcode("1,9,10,3,2,3,11,0,99,30,40,50") ==
             {3500, 9, 10, 70, 2, 3, 11, 0, 99, 30, 40, 50}

    assert Day2.exec_intcode("1,0,0,0,99") == {2, 0, 0, 0, 99}
    assert Day2.exec_intcode("2,3,0,3,99") == {2, 3, 0, 6, 99}
    assert Day2.exec_intcode("2,4,4,5,99,0") == {2, 4, 4, 5, 99, 9801}
    assert Day2.exec_intcode("1,1,1,4,99,5,6,0,99") == {30, 1, 1, 4, 2, 5, 6, 0, 99}
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
end
