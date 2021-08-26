defmodule CliTest do
  use ExUnit.Case
  doctest Repoissues

  import Repoissues.CLI

  test ":help returned by options parsing with -h and --help" do
    assert parse_args(["-h", "value"]) == :help
    assert parse_args(["--help", "value"]) == :help
  end

  test "three values returned if three given" do
    assert parse_args(["usr", "project", "99"]) == {"usr", "project", 99}
  end

  test "three values returned with default issues_count if two given" do
    assert parse_args(["usr", "project"]) == {"usr", "project", 5}
  end

  test "sort descending orders the correct way" do
    result = sort_descending_order(fake_created_at_list(["a", "c", "b"]))
    issues = for issue <- result, do: issue["created_at"]

    assert issues == ~w[c b a]
  end

  defp fake_created_at_list(values) do
    for value <- values, do: %{"created_at" => value, "other_data" => "xxx"}
  end
end
