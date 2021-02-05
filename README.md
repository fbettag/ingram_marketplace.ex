# Ingram Marketplace API

Ingram Micro Marketplace API for running a cloud reselling business.

## Installation

The package can be installed by adding `ingram_marketplace` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:ingram_marketplace, "~> 1.2"}]
end
```

Configure the library with the following lines in your `config.exs`:

```elixir
config :ingram_marketplace,
  url: "https://api-lab.cloud.im/marketplace/dev",
  #url: "https://api.cloud.im/marketplace/eu" # prod
  subscription_key: "<your subscription key>",
  username: "<your username>",
  password: "<your password>"
```

Documentation can be found at [https://hexdocs.pm/ingram_marketplace](https://hexdocs.pm/ingram_marketplace).

## Generating APIs

To install the required dependencies and to build the elixir project, run:

```
npm --prefix node-generator install
cd node-generator
npx openapi-generator-cli generate  -c ../ingram-openapi.json  -g elixir -o Ingram.Marketplace -i https://apidocs.cloud.im/1.1/_specs/cmp.yaml --skip-validate-spec
```
