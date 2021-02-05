defmodule Ingram.Marketplace.Model.SubscriptionItemExtendedPrice do
  @moduledoc """
  A structure representing the total calculated price.
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

defimpl Poison.Decoder, for: Ingram.Marketplace.Model.SubscriptionItemExtendedPrice do
  def decode(value, _options) do
    value
  end
end
