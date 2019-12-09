defmodule Day3 do
  @moduledoc """
  advent of code day 3: intersecting wire manhattan distance
  Store a wire's path as a MapSet
  """

  def day3 do
    dist =
      File.read!("_input/input3.txt")
      |> String.trim_trailing()
      |> find_intersection_distance

    IO.puts("day 3 part 1: min intersection distance #{dist}")
  end

  defp create_path(pos, dir, count) do
    # returns a list of positions resulting from starting at pos, moving dir count times
    # dir should be one of :up, :down, :left, :right
    case count do
      0 ->
        [pos]

      _ ->
        newpos = move(pos, dir)
        [pos | create_path(newpos, dir, count - 1)]
    end
  end

  defp move({x, y}, :up) do
    {x, y + 1}
  end

  defp move({x, y}, :down) do
    {x, y - 1}
  end

  defp move({x, y}, :right) do
    {x + 1, y}
  end

  defp move({x, y}, :left) do
    {x - 1, y}
  end

  defp parse_movement({x, y}, str) do
    # given a starting point and a string like "R3" or "U2", return a set of points in a path
    dir =
      case String.first(str) do
        "U" -> :up
        "D" -> :down
        "R" -> :right
        "L" -> :left
      end

    count =
      str
      |> String.slice(1..-1)
      |> String.to_integer()

    create_path({x, y}, dir, count)
    |> tl

    # we need to take the tail because otherwise the beginning gets duplicated
    # we didn't actually move there
  end

  defp parse_path(str) do
    # converts a string like "R3,U2" into a MapSet like [{0,0},{1,0},{2,0},{3,0},{3,1},{3,2}]
    str
    |> parse_path_list()
    |> MapSet.new()
  end

  defp parse_path_list(str) do
    # converts a string like "R3,U2" into a list like [{0,0},{1,0},{2,0},{3,0},{3,1},{3,2}]
    str
    |> String.trim_trailing()
    |> String.split(",")
    |> Enum.reduce([{0, 0}], fn x, acc ->
      Enum.concat(acc, parse_movement(List.last(acc), x))
    end)
  end

  def find_intersection_distance(str) do
    # finds closest intersection to {0,0} not including {0,0} itself
    # input is expected to be one path per line, two lines
    str
    |> find_intersections()
    |> Enum.map(&manhattan_distance/1)
    |> Enum.min()
  end

  defp find_intersections(str) do
    # finds intersections of 2 paths not including {0,0} itself
    # input is expected to be one path per line, two lines
    str
    |> String.split("\n")
    |> Enum.map(&parse_path/1)
    |> Enum.map(&MapSet.delete(&1, {0, 0}))
    |> find_intersections_paths()
  end

  defp find_intersections_paths([path1, path2]) do
    # inputs expected to be MapSets of coordinate tuples
    MapSet.intersection(path1, path2)
  end

  defp manhattan_distance({x, y}) do
    abs(x) + abs(y)
  end

  # part 2
  def find_intersection_path_distance(str) do
    # finds closest intersection by path length not including {0,0} itself
    # input is expected to be one path per line, two lines
    pathstrs =
      str
      |> String.split("\n")

    str
    |> find_intersections()
    |> Enum.map(&path_distance_total(&1, pathstrs))
    |> Enum.min()
  end

  defp path_distance_total(dest, pathstrs) do
    # dest is a coordinate tuple like {x, y}
    # pathstrs is a list of path strings like "R3,U2"
    pathstrs
    |> Enum.map(&path_distance(dest, &1))
    |> Enum.sum()
  end

  defp path_distance(dest, pathstr) do
    # dest is a coordinate tuple like {x, y}
    # pathstr is a path string like "R3,U2"
    # return the path length to dest
    pathstr
    |> parse_path_list()
    |> find_pos_in_list(dest)
  end

  defp find_pos_in_list(l, target) do
    # count how many elements of list we have to follow to find target
    if hd(l) == target do
      0
    else
      1 + find_pos_in_list(tl(l), target)
    end
  end
end
