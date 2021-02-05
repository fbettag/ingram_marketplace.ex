defmodule Ingram.Marketplace.CustomerManagement do
  @moduledoc """
  API calls for all endpoints tagged `CustomerManagement`.
  """
  import Ingram.Marketplace.RequestBuilder
  alias Ingram.Marketplace.Connection
  alias Ingram.Marketplace.Model

  @doc """
  Create a new customer
  Create a customer in the platform and associate it with the reseller that sends this request.

  ## Parameters

  - post_customer_details (Ingram.Marketplace.Model.PostCustomerDetails):
  - opts (KeywordList): [optional] Optional parameters
  - connection (Ingram.Marketplace.Connection): Connection to server
  ## Returns

  {:ok, %Model.GetCustomerDetails{}} on success
  {:error, info} on failure
  """
  @spec create_customer(
          Model.PostCustomerDetails.t(),
          keyword(),
          Tesla.Env.client() | nil
        ) :: {:ok, Model.GetCustomerDetails.t()} | {:error, Tesla.Env.t()}
  def create_customer(
        post_customer_details,
        _opts \\ [],
        connection \\ Connection.new()
      ) do
    %{}
    |> method(:post)
    |> url("/customers")
    |> add_param(:body, :body, post_customer_details)
    |> Enum.into([])
    |> (&Tesla.request(connection, &1)).()
    |> evaluate_response([
      {200, %Model.GetCustomerDetails{}},
      {400, %Model.ErrorMessage{}},
      {403, %Model.ErrorMessage{}},
      {500, %Model.ErrorMessage{}}
    ])
  end

  @doc """
  Get full details of a specific customer
  Get extended details about a specific customer in the platform.

  ## Parameters

  - id (String.t): The ID of the customer to be processed by the request.
  - opts (KeywordList): [optional] Optional parameters
  - connection (Ingram.Marketplace.Connection): Connection to server
  ## Returns

  {:ok, %Ingram.Marketplace.Model.GetCustomerDetails{}} on success
  {:error, info} on failure
  """
  @spec get_customer_by_id(String.t(), keyword(), Tesla.Env.client() | nil) ::
          {:ok, Model.GetCustomerDetails.t()} | {:error, Tesla.Env.t()}
  def get_customer_by_id(id, _opts \\ [], connection \\ Connection.new()) do
    %{}
    |> method(:get)
    |> url("/customers/#{id}")
    |> Enum.into([])
    |> (&Tesla.request(connection, &1)).()
    |> evaluate_response([
      {200, %Model.GetCustomerDetails{}},
      {400, %Model.ErrorMessage{}},
      {403, %Model.ErrorMessage{}},
      {404, %Model.ErrorMessage{}},
      {500, %Model.ErrorMessage{}}
    ])
  end

  @doc """
  Get a list of customers
  Get a list of customers and their basic details.

  ## Parameters

  - opts (KeywordList): [optional] Optional parameters
    - :name (String.t): Find customers that are similar to the provided name.
    - :email (String.t): Find customers that have a contact person with the provided email address.
    - :externalId (String.t): Find customers that have an external ID assigned equal to the provided ID.
    - :offset (integer()): The number of items to skip before starting to collect the result set.
    - :limit (integer()): The number of items to return.
  - connection (Ingram.Marketplace.Connection): Connection to server
  ## Returns

  {:ok, %Ingram.Marketplace.Model.InlineResponse200{}} on success
  {:error, info} on failure
  """
  @spec get_customers(keyword(), Tesla.Env.client() | nil) ::
          {:ok, Model.InlineResponse200.t()} | {:error, Tesla.Env.t()}
  def get_customers(opts \\ [], connection \\ Connection.new()) do
    optional_params = %{
      :name => :query,
      :email => :query,
      :externalId => :query,
      :offset => :query,
      :limit => :query
    }

    %{}
    |> method(:get)
    |> url("/customers")
    |> add_optional_params(optional_params, opts)
    |> Enum.into([])
    |> (&Tesla.request(connection, &1)).()
    |> evaluate_response([
      {200, %Model.InlineResponse200{}},
      {403, %Model.ErrorMessage{}},
      {500, %Model.ErrorMessage{}}
    ])
  end
end
