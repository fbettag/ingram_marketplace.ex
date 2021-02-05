defmodule Ingram.Marketplace.Model.OrderProductEstimation do
  @moduledoc """
  The extended representation of a specific order product estimation with information about the price.
  """

  @derive [Poison.Encoder]
  defstruct [
    :mpn,
    :quantity,
    :extendedPrice
  ]

  @type t :: %__MODULE__{
          :mpn => String.t() | nil,
          :quantity => float(),
          :extendedPrice => OrderItemPrice | nil
        }
end

defimpl Poison.Decoder, for: Ingram.Marketplace.Model.OrderProductEstimation do
  import Ingram.Marketplace.Deserializer

  def decode(value, options) do
    value
    |> deserialize(:extendedPrice, :struct, Ingram.Marketplace.Model.OrderItemPrice, options)
  end
end
