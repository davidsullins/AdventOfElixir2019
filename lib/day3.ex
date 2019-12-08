defmodule Day3 do
  @moduledoc """
  advent of code day 3: intersecting wire manhattan distance
  Store a wire's path as a MapSet
  """

  def day3 do
    # TODO
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

  def parse_movement({x, y}, str) do
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
  end

  def parse_path(str) do
    # converts a string like "R3,U2" into a MapSet like [{0,0},{1,0},{2,0},{3,0},{3,1},{3,2}]
    str
    |> String.trim_trailing()
    |> String.split(",")
    |> Enum.reduce([{0, 0}], fn x, acc ->
      Enum.concat(acc, Day3.parse_movement(List.last(acc), x))
    end)
    |> MapSet.new()
  end

  def find_intersection_distance(str) do
    # finds closest intersection to {0,0} not including {0,0} itself
    # input is expected to be one path per line, two lines
    paths =
      str
      |> String.split("\n")
      |> Enum.map(&Day3.parse_path/1)
      |> Enum.map(&MapSet.delete(&1, {0, 0}))

    MapSet.intersection(hd(paths), Enum.at(paths, 1))
    |> Enum.map(&Day3.manhattan_distance/1)
    |> Enum.min()
  end

  def manhattan_distance({x, y}) do
    abs(x) + abs(y)
  end
end
