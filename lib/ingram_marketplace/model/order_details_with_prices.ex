defmodule Ingram.Marketplace.Model.OrderDetailsWithPrices do
  @moduledoc """
  The extended representation of a specific order with additional information about the ordered items.
  """

  @derive [Poison.Encoder]
  defstruct [
    :products,
    :id,
    :type,
    :customerId,
    :creationDate,
    :status
  ]

  @type t :: %__MODULE__{
          :products => [OrderProductWithPrice],
          :id => String.t(),
          :type => String.t() | nil,
          :customerId => String.t(),
          :creationDate => DateTime.t(),
          :status => String.t()
        }
end

defimpl Poison.Decoder, for: Ingram.Marketplace.Model.OrderDetailsWithPrices do
  import Ingram.Marketplace.Deserializer

  def decode(value, options) do
    value
    |> deserialize(:products, :list, Ingram.Marketplace.Model.OrderProductWithPrice, options)
  end
end
