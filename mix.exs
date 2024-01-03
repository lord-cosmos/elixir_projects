defmodule Example.MixProject do
  use Mix.Project

  def project do
    [
      app: :example,
      version: "0.1.0",
      elixir: "~> 1.15",
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

    # if Mix.env == :dev do
    #   IO.puts("This is development environment")
    # end
    [
      {:dep_from_hexpm, "~> 0.3.0"},
      {:ex_doc, "~> 0.21", only: :dev, runtime: false}
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]

  end
end

# We specify the only: :dev key-value pair as we don’t want to
# download and compile the ex_doc dependency in a production environment.
