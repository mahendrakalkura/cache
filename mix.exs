defmodule Cache.Mixfile do
  @moduledoc false

  use Mix.Project

  def application do
    [
      applications: []
    ]
  end

  def deps do
    [
      {:credo, "~> 0.4"},
      {:dogma, "~> 0.1"},
      {:exjsx, "~> 3.2"}
    ]
  end

  def project do
    [
      app: :cache,
      build_embedded: Mix.env == :prod,
      deps: deps(),
      elixir: "~> 1.3",
      start_permanent: Mix.env == :prod,
      version: "0.1.0"
    ]
  end
end
