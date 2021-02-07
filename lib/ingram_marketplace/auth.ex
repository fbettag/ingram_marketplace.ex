defmodule Ingram.Marketplace.Auth do
  @moduledoc """
  Keeps the required bearer token around and refreshes it when required.
  """
  use Agent
  require Logger

  @doc """
  Starts the Auth-Agent.
  """
  @spec start(any(), any()) :: {:ok, integer()}
  def start(_type, _args) do
    Agent.start_link(fn -> refresh_token() end, name: __MODULE__)
  end

  @doc """
  Returns the bearer token or fetches a new one if required.
  """
  @spec token() :: String.t()
  def token do
    token = Agent.get_and_update(__MODULE__, fn state -> get_token(state) end)
    token
  end

  defp refresh_token(retry \\ 0) do
    if retry >= 3 do
      %{token: "", expires_in: :os.system_time(:seconds)}
    else
      url = Application.get_env(:ingram_marketplace, :url)
      username = Application.get_env(:ingram_marketplace, :username)
      password = Application.get_env(:ingram_marketplace, :password)
      subscription_key = Application.get_env(:ingram_marketplace, :subscription_key)

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
          body: %{token: bearer, expiresInSeconds: expires_in}
        } ->
          %{token: bearer, expires_in: :os.system_time(:seconds) + expires_in}

        %Tesla.Env{status: status, body: body} ->
          Logger.error(
            "[Ingram.Marketplace.Auth] Error fetching token: status #{status}: #{body}"
          )

          :timer.sleep(:timer.seconds(10))
          refresh_token(retry + 1)
      end
    end
  end

  defp get_token(%{expires_in: expires_in, token: token} = state) do
    now = :os.system_time(:seconds)

    # I am greedy ^_^
    has_aged? = now + 5 > expires_in

    if has_aged? do
      # Refresh OAuth token as it has aged
      auth = refresh_token()
      {auth.token, auth}
    else
      # No need to refresh, send back the same token
      {token, state}
    end
  end
end
