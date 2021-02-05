defmodule Ingram.Marketplace.Model.OrderEstimationRequest do
  @moduledoc """
  The representation of an order to be estimated.
  """

  @derive [Poison.Encoder]
  defstruct [
    :type,
    :customerId,
    :products
  ]

  @type t :: %__MODULE__{
          :type => String.t(),
          :customerId => String.t(),
          :products => [OrderProductToEstimation]
        }
end

defimpl Poison.Decoder, for: Ingram.Marketplace.Model.OrderEstimationRequest do
  import Ingram.Marketplace.Deserializer

  def decode(value, options) do
    value
    |> deserialize(:products, :list, Ingram.Marketplace.Model.OrderProductToEstimation, options)
  end
end
