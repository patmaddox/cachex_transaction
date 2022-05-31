defmodule CachexTransaction.MixProject do
  use Mix.Project

  def project do
    [
      app: :cachex_transaction,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {CachexTransaction.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto, "~> 3.8"},
      {:ecto_sql, "~> 3.8"},
      {:postgrex, ">= 0.0.0"}
    ]
  end
end
