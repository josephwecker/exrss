defmodule RssPoll.Mixfile do
  use Mix.Project

  def project do
    [ app: :rss_poll,
      version: "0.0.1",
      elixir: "~> 0.10.1",
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    [ applications: [:httpotion,:xmerl]]
  end

  # Returns the list of dependencies in the format:
  # { :foobar, "~> 0.1", git: "https://github.com/elixir-lang/foobar.git" }
  defp deps do
    [
      {:httpotion, "0.2.0",[github: "myfreeweb/httpotion"]}
    ]
  end
end
