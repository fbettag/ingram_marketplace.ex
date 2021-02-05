defmodule Ingram.Marketplace.Model.OrderProductWithPrice do
  @moduledoc """
  The extended representation of a specific order product with price information about items.
  """

  @derive [Poison.Encoder]
  defstruct [
    :mpn,
    :name,
    :quantity,
    :subscriptionId,
    :extendedPrice
  ]

  @type t :: %__MODULE__{
          :mpn => String.t() | nil,
          :name => String.t() | nil,
          :quantity => float(),
          :subscriptionId => String.t() | nil,
          :extendedPrice => OrderItemPrice | nil
        }
end

defimpl Poison.Decoder, for: Ingram.Marketplace.Model.OrderProductWithPrice do
  import Ingram.Marketplace.Deserializer

  def decode(value, options) do
    value
    |> deserialize(:extendedPrice, :struct, Ingram.Marketplace.Model.OrderItemPrice, options)
  end
end
