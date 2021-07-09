defmodule Ingram.Marketplace.Connection do
  @moduledoc """
  Handle Tesla connections for Ingram.Model.
  """
  alias Ingram.Marketplace.Auth

  @doc """
  Configure a client connection using a provided OAuth2 token as a Bearer token and subscription key.

  ## Parameters

  - subscription_key (String.t): The ID of your reseller's subscription on the API gateway that defines restrictions on your API calls.
  - token (String): Bearer token

  ## Returns

  Tesla.Env.client
  """
  @spec new(String.t(), String.t()) :: Tesla.Env.client()
  def new(subscription_key, token) when is_binary(token) do
    url = Application.get_env(:ingram_marketplace, :url)

    middleware = [
      {Tesla.Middleware.BaseUrl, url},
      {Tesla.Middleware.Timeout, timeout: 120_000},
      {Tesla.Middleware.EncodeJson, engine: Poison},
      {
        Tesla.Middleware.Headers,
        [
          {"User-Agent", "Elixir"},
          {"Content-Type", "application/json"},
          {"Authorization", "Bearer #{token}"},
          {"X-Subscription-Key", subscription_key}
        ]
      }
    ]

    Tesla.client(middleware, {Tesla.Adapter.Hackney, [timeout: 120_000]})
  end

  @doc """
  Configure a client with a subscription key and the credentials specified in config.exs.

  # Returns

  Tesla.Env.client
  """
  @spec new() :: Tesla.Env.client()
  def new do
    subscription_key = Application.get_env(:ingram_marketplace, :subscription_key)

    Auth.token()

    subscription_key
    |> new(Auth.token())
  end
end
