defmodule GithubIssuesTest do
  use ExUnit.Case
  doctest Repoissues

  import Repoissues.GithubIssues 

  test "Valid Github URL returnd if passed user and project" do
    user = "davidalencar"
    repo = "foodlike_frontend"
    assert issues_url(user, repo) == "https://api.github.com/repos/#{user}/#{repo}/issues" 
  end
end
