defmodule Ingram.Marketplace.ProductCatalog do
  @moduledoc """
  API calls for all endpoints tagged `ProductCatalog`.
  """
  import Ingram.Marketplace.RequestBuilder
  alias Ingram.Marketplace.Connection
  alias Ingram.Marketplace.Model

  @doc """
  Get a list of products from the product catalog
  Get a list of products available for the requester to sell or resell with details included.

  ## Parameters

  - opts (KeywordList): [optional] Optional parameters
    - :offset (integer()): The number of items to skip before starting to collect the result set.
    - :limit (integer()): The number of items to return.
    - :mpn (String.t): MPN value
  - connection (Ingram.Marketplace.Connection): Connection to server
  ## Returns

  {:ok, %Ingram.Marketplace.Model.InlineResponse2001{}} on success
  {:error, info} on failure
  """
  @spec get_catalog(keyword(), Tesla.Env.client() | nil) ::
          {:ok, Model.InlineResponse2001.t()} | {:error, Tesla.Env.t()}
  def get_catalog(opts \\ [], connection \\ Connection.new()) do
    optional_params = %{
      :offset => :query,
      :limit => :query,
      :mpn => :query
    }

    %{}
    |> method(:get)
    |> url("/products")
    |> add_optional_params(optional_params, opts)
    |> Enum.into([])
    |> (&Tesla.request(connection, &1)).()
    |> evaluate_response([
      {200, %Model.InlineResponse2001{}},
      {403, %Model.ErrorMessage{}},
      {500, %Model.ErrorMessage{}}
    ])
  end
end
