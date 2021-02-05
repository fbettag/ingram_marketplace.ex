defmodule Ingram.Marketplace.Connection do
  @moduledoc """
  Handle Tesla connections for Ingram.Model.
  """

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

    Tesla.client(middleware, {Tesla.Adapter.Hackney, [timeout: 60_000]})
  end

  @doc """
  Configure a client with a subscription key and the credentials specified in config.exs.

  # Returns

  Tesla.Env.client
  """
  @spec new(String.t()) :: Tesla.Env.client()
  def new(subscription_key) do
    token = get_token(subscription_key)
    new(subscription_key, token)
  end

  @doc """
  Configure a client with a subscription key and the credentials specified in config.exs.

  # Returns

  Tesla.Env.client
  """
  @spec new() :: Tesla.Env.client()
  def new do
    :ingram_marketplace
    |> Application.get_env(:subscription_key)
    |> new()
  end

  defp get_token(subscription_key) do
    url = Application.get_env(:ingram_marketplace, :url)
    username = Application.get_env(:ingram_marketplace, :username)
    password = Application.get_env(:ingram_marketplace, :password)

    middleware = [
      {Tesla.Middleware.BaseUrl, url},
      {Tesla.Middleware.BasicAuth, %{username: username, password: password}},
      {Tesla.Middleware.Timeout, timeout: 60_000},
      {
        Tesla.Middleware.JSON,
        engine: Poison,
        engine_opts: [
          keys: :atoms
        ]
      },
      {
        Tesla.Middleware.Headers,
        [
          {"User-Agent", "Elixir"},
          {"Content-Length", "0"},
          {"Content-Type", "application/json"},
          {"X-Subscription-Key", subscription_key}
        ]
      }
    ]

    client = Tesla.client(middleware, {Tesla.Adapter.Hackney, [timeout: 60_000]})

    case Tesla.post!(client, "/token", "") do
      %Tesla.Env{
        status: 200,
        body: %{
          token: bearer
        }
      } ->
        bearer

      %Tesla.Env{status: status, body: body} ->
        raise "#{status}: #{body}"
    end
  end
end
