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
end
