defmodule Repoissues.CLI do
  @default_issues 5

  @moduledoc """
  last _n_ issues in a github project
  """
  def run(argv) do
    argv
    |> parse_args
    |> process
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

  def process({user, repo, _}) do
    Repoissues.GithubIssues.fetch(user, repo)
    |> decode_response()
  end

  def decode_response({:ok, body}), do: body
  def decode_response({:error, error}) do
    IO.puts "Error fetching from Github: #{error["message"]}"
    System.halt(2)
  end
end
