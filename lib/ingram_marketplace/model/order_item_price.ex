defmodule Ingram.Marketplace.Model.OrderItemPrice do
  @moduledoc """
  A structure representing the ordered item (one or more products) price.
  """

  @derive [Poison.Encoder]
  defstruct [
    :amount,
    :currency
  ]

  @type t :: %__MODULE__{
          :amount => String.t(),
          :currency => String.t()
        }
end

defimpl Poison.Decoder, for: Ingram.Marketplace.Model.OrderItemPrice do
  def decode(value, _options) do
    value
  end
end
