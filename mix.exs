defmodule Issues.MixProject do
  use Mix.Project

  def project do
    [
      app: :issues,
      version: "0.1.0",
      name: "Issues",
      source_url: "https://github.com/takeshi-itami/issues",
      elixir: "~> 1.9",
      escript: escript_config(),
      start_permanent: Mix.env() == :prod,
      deps: deps()
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
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:httpoison, "~> 1.7"},
      {:poison, "~> 4.0"},
      {:ex_doc, "~> 0.22.1"},
      {:earmark, "~> 1.4"}
    ]
  end

  defp escript_config do
    [
      main_module: Issues.CLI
    ]
  end
end
