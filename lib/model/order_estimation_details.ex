defmodule Ingram.Marketplace.Model.OrderEstimationDetails do
  @moduledoc """
  The representation of an order estimation.
  """

  @derive [Poison.Encoder]
  defstruct [
    :total,
    :products
  ]

  @type t :: %__MODULE__{
          :total => TotalOrderPriceEstimation,
          :products => [OrderProductEstimation]
        }
end

defimpl Poison.Decoder, for: Ingram.Marketplace.Model.OrderEstimationDetails do
  import Ingram.Marketplace.Deserializer

  def decode(value, options) do
    value
    |> deserialize(:total, :struct, Ingram.Marketplace.Model.TotalOrderPriceEstimation, options)
    |> deserialize(:products, :list, Ingram.Marketplace.Model.OrderProductEstimation, options)
  end
end
