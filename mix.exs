defmodule ExMarketo.MixProject do
  use Mix.Project

  @version "0.1.1"

  def project do
    [
      app: :ex_marketo,
      version: @version,
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      elixirc_paths: elixirc_paths(Mix.env()),
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test,
        "coveralls.json": :test
      ],
      dialyzer: [
        list_unused_filters: true,
        plt_add_apps: [:mix],
        plt_file: {:no_warn, ".plts/dialyzer.plt"},
        ignore_warnings: "dialyzer_ignore.exs"
      ],
      name: "ex marketo",
      source_url: "https://github.com/bumpah/ex_marketo",
      description: description(),
      package: package()
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {ExMarketo.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.7.0", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.3.0", only: [:dev], runtime: false},
      {:ex_doc, "~> 0.21", only: :dev, runtime: false},
      {:ex_machina, "~> 2.4", only: :test},
      {:excoveralls, "~> 0.13", only: :test},
      {:gen_stage, "~> 1.2.1"},
      {:tesla, "~> 1.7.0"}
    ]
  end

  defp description do
    """
    Marketo REST api client
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Jimi Pajala"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/bumpah/ex_marketo"}
    ]
  end
end
