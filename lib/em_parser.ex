defmodule EMParser do
  @moduledoc """
  Documentation for EMParser.
  """

  @doc """
  Parse a float or integer number.

    iex> EMParser.to_number("123")
    {123, ""}
    iex> EMParser.to_number("123.4")
    {123.4, ""}
    iex> EMParser.to_number("123.4+123")
    {123.4, "+123"}
    iex> EMParser.to_number("123+123.4")
    {123, "+123.4"}
    iex> EMParser.to_number("a+123.4")
    "a+123.4"
  """
  def to_number(expr) do
    [&:string.to_float/1, &:string.to_integer/1]
    |> Enum.reduce_while(String.trim_leading(expr), fn fun, expr ->
      case fun.(expr) do
        {:error, _} -> {:cont, expr}
        result -> {:halt, result}
      end
    end)
  end
end
