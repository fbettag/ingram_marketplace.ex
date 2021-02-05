defmodule Ingram.Marketplace.ValidationManagement do
  @moduledoc """
  API calls for all endpoints tagged `ValidationManagement`.
  """
  import Ingram.Marketplace.RequestBuilder
  alias Ingram.Marketplace.Connection
  alias Ingram.Marketplace.Model

  @doc """
  Validate product activation parameters
  Validate activation parameters for a set of products.

  ## Parameters

  - validation_parameters (Ingram.Marketplace.Model.ValidationParameters):
  - opts (KeywordList): [optional] Optional parameters
  - connection (Ingram.Marketplace.Connection): Connection to server
  ## Returns

  {:ok, %Ingram.Marketplace.Model.ValidationParametersResult{}} on success
  {:error, info} on failure
  """
  @spec validation_parameters_post(
          Model.ValidationParameters.t(),
          keyword(),
          Tesla.Env.client() | nil
        ) ::
          {:ok, Model.ValidationParametersResult.t()} | {:error, Tesla.Env.t()}
  def validation_parameters_post(
        validation_parameters,
        _opts \\ [],
        connection \\ Connection.new()
      ) do
    %{}
    |> method(:post)
    |> url("/validation/parameters")
    |> add_param(:body, :body, validation_parameters)
    |> Enum.into([])
    |> (&Tesla.request(connection, &1)).()
    |> evaluate_response([
      {200, %Model.ValidationParametersResult{}}
    ])
  end
end
