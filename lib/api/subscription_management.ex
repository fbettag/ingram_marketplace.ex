defmodule Ingram.Marketplace.SubscriptionManagement do
  @moduledoc """
  API calls for all endpoints tagged `SubscriptionManagement`.
  """
  import Ingram.Marketplace.RequestBuilder
  alias Ingram.Marketplace.Connection
  alias Ingram.Marketplace.Model

  @doc """
  Get full details of a specific subscription
  Get extended details of a specific subscription from the platform.

  ## Parameters

  - id (String.t): This is the ID of the subscription that must be processed by the request.
  - opts (KeywordList): [optional] Optional parameters
  - connection (Ingram.Marketplace.Connection): Connection to server
  ## Returns

  {:ok, %Ingram.Marketplace.Model.SubscriptionDetails{}} on success
  {:error, info} on failure
  """
  @spec get_subscription(String.t(), keyword(), Tesla.Env.client() | nil) ::
          {:ok, Model.SubscriptionDetails.t()} | {:error, Tesla.Env.t()}
  def get_subscription(id, _opts \\ [], connection \\ Connection.new()) do
    %{}
    |> method(:get)
    |> url("/subscriptions/#{id}")
    |> Enum.into([])
    |> (&Tesla.request(connection, &1)).()
    |> evaluate_response([
      {200, %Model.SubscriptionDetails{}}
    ])
  end

  @doc """
  Retrieve a list of subscriptions
  Get a list of subscriptions belonging to the customers of the reseller that sends the request.

  ## Parameters

  - opts (KeywordList): [optional] Optional parameters
    - :customer_id (String.t): The ID of the subscription owner.
    - :status (String.t): The Subscription status filter. Available statuses:   * `pending`   * `active`   * `hold`   * `terminated`   * `removed`
    - :creation_date_from (Date.t): Find subscriptions that were created after the specified date.
    - :creation_date_to (Date.t): Find subscriptions that were created before the specified date.
    - :offset (integer()): The number of items to skip before starting to collect the result set.
    - :limit (integer()): The number of items to return.
  - connection (Ingram.Marketplace.Connection): Connection to server
  ## Returns

  {:ok, %Ingram.Marketplace.Model.InlineResponse2003{}} on success
  {:error, info} on failure
  """
  @spec get_subscriptions(keyword(), Tesla.Env.client() | nil) ::
          {:ok, Model.InlineResponse2003.t()} | {:error, Tesla.Env.t()}
  def get_subscriptions(opts \\ [], connection \\ Connection.new()) do
    optional_params = %{
      :customerId => :query,
      :status => :query,
      :creationDateFrom => :query,
      :creationDateTo => :query,
      :offset => :query,
      :limit => :query
    }

    %{}
    |> method(:get)
    |> url("/subscriptions")
    |> add_optional_params(optional_params, opts)
    |> Enum.into([])
    |> (&Tesla.request(connection, &1)).()
    |> evaluate_response([
      {200, %Model.InlineResponse2003{}},
      {403, %Model.ErrorMessage{}},
      {500, %Model.ErrorMessage{}}
    ])
  end
end
