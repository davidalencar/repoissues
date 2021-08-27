defmodule Repoissues.MixProject do
  use Mix.Project

  def project do
    [
      app: :repoissues,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      escript: escript_config(),

      #Docs
      name: "Repo-Issues3000",
      source_url: "https://github.com/davidalencar/repoissues"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 1.8"},
      {:poison, "~> 5.0"},
      {:ex_doc, "~> 0.24", only: :dev, runtime: false}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end

  def escript_config do
    [main_module: Repoissues.CLI]
  end
end
