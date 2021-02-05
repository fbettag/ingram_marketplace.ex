defmodule Ingram.Marketplace.Model.SubscriptionItem do
  @moduledoc """
  The structure representing an individual product item in the subscription. A subscription may have one or more of these items.
  """

  @derive [Poison.Encoder]
  defstruct [
    :mpn,
    :quantity,
    :unitPrice,
    :extendedPrice
  ]

  @type t :: %__MODULE__{
          :mpn => String.t() | nil,
          :quantity => float() | nil,
          :unitPrice => SubscriptionItemUnitPrice | nil,
          :extendedPrice => SubscriptionItemExtendedPrice | nil
        }
end

defimpl Poison.Decoder, for: Ingram.Marketplace.Model.SubscriptionItem do
  import Ingram.Marketplace.Deserializer

  def decode(value, options) do
    value
    |> deserialize(
      :unitPrice,
      :struct,
      Ingram.Marketplace.Model.SubscriptionItemUnitPrice,
      options
    )
    |> deserialize(
      :extendedPrice,
      :struct,
      Ingram.Marketplace.Model.SubscriptionItemExtendedPrice,
      options
    )
  end
end
