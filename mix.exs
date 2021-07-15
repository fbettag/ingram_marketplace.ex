defmodule IngramMarketplace.Mixfile do
  use Mix.Project

  @project_url "https://github.com/fbettag/ingram_marketplace.ex"

  def project do
    [
      app: :ingram_marketplace,
      version: "1.4.6",
      elixir: "~> 1.7",
      source_url: @project_url,
      homepage_url: @project_url,
      name: "Ingram Marketplace API",
      description: "Implements the Ingram Marketplace API",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      package: package(),
      aliases: aliases(),
      deps: deps(),
      dialyzer: [
        plt_add_deps: :apps_direct
      ]
    ]
  end

  defp package do
    [
      name: "ingram_marketplace",
      maintainers: ["Franz Bettag"],
      licenses: ["MIT"],
      links: %{"GitHub" => @project_url},
      files: ~w(lib LICENSE README.md mix.exs)
    ]
  end

  defp aliases do
    [credo: "credo -a --strict"]
  end

  defp deps do
    [
      {:tesla, "~> 1.4"},
      {:poison, "~> 3.0"},
      {:hackney, "~> 1.17"},
      {:ex_doc, "~> 0.19", only: :dev},
      {:doctor, "~> 0.17.0", only: :dev},
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false},
      {:credo, github: "rrrene/credo", only: [:dev, :test]},
      {:git_hooks, "~> 0.4.0", only: [:test, :dev], runtime: false}
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end
end
