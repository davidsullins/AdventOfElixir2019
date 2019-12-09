defmodule Day4 do
  @moduledoc """
  advent of code day 4: guess the password
  """

  def day4 do
    [first, last] =
      File.read!("_input/input4.txt")
      |> String.trim_trailing()
      |> String.split("-")
      |> Enum.map(&String.to_integer/1)

    count = count_valid_passwords(first, last)

    IO.puts("day 4 part 1: valid password count #{count}")
  end

  defp count_valid_passwords(first, last) do
    first..last
    |> Enum.filter(&is_valid_password/1)
    |> length
  end

  def is_valid_password(num) do
    is_six_digit(num) and two_adjacent_same(num) and digits_never_decrease(num)
  end

  defp is_six_digit(num) do
    num > 99_999 and num < 1_000_000
  end

  defp two_adjacent_same(num) do
    # true if number has two adjacent digits the same, like 22 in 122345
    num
    |> digit_list_from_int
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.any?(fn [x, y] -> x == y end)
  end

  defp digits_never_decrease(num) do
    # true if digits from left to right never decrease. can stay the same or increase
    # like 111123 or 135679
    num
    |> digit_list_from_int
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.all?(fn [x, y] -> x <= y end)
  end

  defp digit_list_from_int(x) do
    if x < 10 do
      [x]
    else
      digit_list_from_int(div(x, 10)) ++ [rem(x, 10)]
    end
  end
end
