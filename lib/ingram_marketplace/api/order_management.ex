defmodule Ingram.Marketplace.OrderManagement do
  @moduledoc """
  API calls for all endpoints tagged `OrderManagement`.
  """
  import Ingram.Marketplace.RequestBuilder
  alias Ingram.Marketplace.Connection
  alias Ingram.Marketplace.Model

  @doc """
  Create a new order
  Place an order for a set of products for a specific customer.

  ## Parameters

  - order_details (Ingram.Marketplace.Model.OrderDetails):
  - opts (KeywordList): [optional] Optional parameters
  - connection (Ingram.Marketplace.Connection): Connection to server
  ## Returns

  {:ok, %Ingram.Marketplace.Model.Order{}} on success
  {:error, info} on failure
  """
  @spec create_order(
          Model.OrderDetails.t(),
          keyword(),
          Tesla.Env.client() | nil
        ) :: {:ok, Model.Order.t()} | {:error, Tesla.Env.t()}
  def create_order(order_details, _opts \\ [], connection \\ Connection.new()) do
    %{}
    |> method(:post)
    |> url("/orders")
    |> add_param(:body, :body, order_details)
    |> Enum.into([])
    |> (&Tesla.request(connection, &1)).()
    |> evaluate_response([
      {200, %Model.Order{}},
      {403, %Model.ErrorMessage{}},
      {500, %Model.ErrorMessage{}}
    ])
  end

  @doc """
  Estimate an order price
  Get estimated prices of an order.

  ## Parameters

  - order_estimation_request (Ingram.Marketplace.Model.OrderEstimationRequest):
  - opts (KeywordList): [optional] Optional parameters
  - connection (Ingram.Marketplace.Connection): Connection to server
  ## Returns

  {:ok, %Ingram.Marketplace.Model.OrderEstimationDetails{}} on success
  {:error, info} on failure
  """
  @spec estimate_order(
          Model.OrderEstimationRequest.t(),
          keyword(),
          Tesla.Env.client() | nil
        ) :: {:ok, Model.OrderEstimationDetails.t()} | {:error, Tesla.Env.t()}
  def estimate_order(
        order_estimation_request,
        _opts \\ [],
        connection \\ Connection.new()
      ) do
    %{}
    |> method(:post)
    |> url("/orders/estimate")
    |> add_param(:body, :body, order_estimation_request)
    |> Enum.into([])
    |> (&Tesla.request(connection, &1)).()
    |> evaluate_response([
      {200, %Model.OrderEstimationDetails{}},
      {403, %Model.ErrorMessage{}},
      {500, %Model.ErrorMessage{}}
    ])
  end

  @doc """
  Get full details of a specific order
  Get extended details of a specific order.

  ## Parameters

  - id (String.t): This is the ID of the order that must be processed by the request.
  - opts (KeywordList): [optional] Optional parameters
  - connection (Ingram.Marketplace.Connection): Connection to server
  ## Returns

  {:ok, %Ingram.Marketplace.Model.OrderDetailsWithPrices{}} on success
  {:error, info} on failure
  """
  @spec get_order_details(String.t(), keyword(), Tesla.Env.client() | nil) ::
          {:ok, Model.OrderDetailsWithPrices.t()} | {:error, Tesla.Env.t()}
  def get_order_details(id, _opts \\ [], connection \\ Connection.new()) do
    %{}
    |> method(:get)
    |> url("/orders/#{id}")
    |> Enum.into([])
    |> (&Tesla.request(connection, &1)).()
    |> evaluate_response([
      {200, %Model.OrderDetailsWithPrices{}},
      {403, %Model.ErrorMessage{}},
      {404, %Model.ErrorMessage{}},
      {500, %Model.ErrorMessage{}}
    ])
  end

  @doc """
  Get a list of orders
  Get basic details of orders in the platform.

  ## Parameters

  - opts (KeywordList): [optional] Optional parameters
    - :offset (integer()): The number of items to skip before starting to collect the result set.
    - :limit (integer()): The number of items to return.
    - :customerId (String.t): The ID of the customer for whom the order was placed.
    - :status (String.t): The order status that can be one of the following:   * `submitted`   * `processing`   * `error`   * `completed`   * `cancelled`
    - :subscriptionId (String.t): The ID of the subscription created from the order.
    - :creationTimeFrom (DateTime.t): This is the beginning of a specific period of time used to search for orders created during that same period.
    - :creationTimeTo (DateTime.t): This is the end of a specific period of time used to search for orders created during that same period.
  - connection (Ingram.Marketplace.Connection): Connection to server
  ## Returns

  {:ok, %Ingram.Marketplace.Model.InlineResponse2002{}} on success
  {:error, info} on failure
  """
  @spec get_orders(keyword(), Tesla.Env.client() | nil) ::
          {:ok, Model.InlineResponse2002.t()} | {:error, Tesla.Env.t()}
  def get_orders(opts \\ [], connection \\ Connection.new()) do
    optional_params = %{
      :offset => :query,
      :limit => :query,
      :customerId => :query,
      :status => :query,
      :subscriptionId => :query,
      :creationTimeFrom => :query,
      :creationTimeTo => :query
    }

    %{}
    |> method(:get)
    |> url("/orders")
    |> add_optional_params(optional_params, opts)
    |> Enum.into([])
    |> (&Tesla.request(connection, &1)).()
    |> evaluate_response([
      {200, %Model.InlineResponse2002{}},
      {403, %Model.ErrorMessage{}},
      {500, %Model.ErrorMessage{}}
    ])
  end
end
