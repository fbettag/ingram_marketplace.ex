defmodule Ingram.Marketplace.Model.SubscriptionItemUnitPrice do
  @moduledoc """
  A structure representing the unit price of the product at which the product was ordered.
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

defimpl Poison.Decoder, for: Ingram.Marketplace.Model.SubscriptionItemUnitPrice do
  def decode(value, _options) do
    value
  end
end
