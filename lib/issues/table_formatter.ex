defmodule Issues.TableFormatter do
  def print_table_for_columns(rows, headers) do
    with data_by_columns = split_into_columns(rows, headers),
         column_widths = widths_of(data_by_columns),
         format = format_for(column_widths) do
      puts_one_line_in_columns(headers, format)
      IO.puts(separator(column_widths))
      puts_in_columns(data_by_columns, format)
    end
  end

  @doc """
  Given a list of rows, where each row contains a keyed list
  of columns, return a list containing lists of the data in
  each column. The `headers` parameter contains the list of
  columns to extract.

  iex> list = [
  ...>    %{"a" => "a1", "b" => "b1", "c" => "c1"},
  ...>    %{"a" => "a2", "b" => "b2", "c" => "c2"},
  ...>  ]
  iex> Issues.TableFormatter.split_into_columns(list, ["a", "c"])
  [["a1", "a2"], ["c1", "c2"]]
  """
  def split_into_columns(rows, headers) do
    for header <- headers do
      for row <- rows, do: printable(row[header])
    end
  end

  @doc """
  Return a binary (string) version of our parameter.
  ## Examples
  iex> Issues.TableFormatter.printable("a")
  "a"
  iex> Issues.TableFormatter.printable(99)
  "99"
  """
  def printable(str) when is_binary(str), do: str
  def printable(str), do: to_string(str)

  def widths_of(columns) do
    for column <- columns, do: column |> Enum.map(&String.length/1) |> Enum.max()
  end

  def format_for(column_widths) do
    Enum.map_join(column_widths, " | ", fn width -> "~-#{width}s" end) <> "~n"
  end

  def separator(column_widths) do
    Enum.map_join(column_widths, "-+-", fn width -> List.duplicate("-", width) end)
  end

  def puts_in_columns(data_by_columns, format) do
    data_by_columns
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.each(&puts_one_line_in_columns(&1, format))
  end

  def puts_one_line_in_columns(fields, format) do
    :io.format(format, fields)
  end
end
