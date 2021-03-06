defmodule Repoissues.CLI do
  alias Repoissues.TableFormatter, as: TF
  @default_issues 5

  @moduledoc """
  last _n_ issues in a github project
  """

  def main(argv) do
    argv
    |> parse_args()
    |> process()
  end

  def run(argv) do
    argv
    |> parse_args
    |> process
    |> sort_descending_order
  end

  def parse_args(["--help" | _]) do
    :help
  end

  def parse_args(["-h" | _]) do
    :help
  end

  def parse_args([user, project]) do
    parse_args([user, project, "#{@default_issues}"])
  end

  def parse_args([user, project, issues_count]) do
    {user, project, String.to_integer(issues_count)}
  end

  def process(:help) do
    IO.puts("""
    usage: repoissues <user> <project> [count|#{@default_issues}]
    """)
    System.halt(0)
  end

  def process({user, repo, count}) do
    Repoissues.GithubIssues.fetch(user, repo)
    |> decode_response()
    |> sort_descending_order()
    |> last(count)
    |>TF.print_table_for_columns(["numbers", "created_at", "title"])
  end

  def decode_response({:ok, body}), do: body
  def decode_response({:error, error}) do
    IO.puts "Error fetching from Github: #{error["message"]}"
    System.halt(2)
  end

  def sort_descending_order(list_of_issues) do
    Enum.sort(list_of_issues, &(&1["created_at"] >= &2["created_at"]))
  end

  def last(list, count) do
    Enum.take(list, count)
    
  end
end
