defmodule Repoissues.GithubIssues do

  require Logger
  @github_url Application.get_env(:repoissues,:github_url)
  @user_agent [{"User-agent", "Elixir davidalencarignacio@gmail.com"}]

  def fetch(user, repo) do
    Logger.info("Fetching #{user}'s project #{repo}")
    issues_url(user, repo)
    |> HTTPoison.get(@user_agent)
    |> handle_response
  end

  def issues_url(user, repo) do
    "#{@github_url}/repos/#{user}/#{repo}/issues"
  end

  def handle_response({_, %{status_code: status_code, body: body}}) do
    Logger.info("Got a response with status: #{status_code}")
    Logger.debug(fn -> inspect(body) end)

    {
      status_code |> check_for_error(),
      body |> Poison.Parser.parse!()
    }
  end
  def check_for_error(200), do: :ok
  def check_for_error(_), do: :error
end
