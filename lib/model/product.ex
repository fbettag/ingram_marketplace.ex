defmodule Ingram.Marketplace.Model.Product do
  @moduledoc """
  The representation of a product for sale.
  """

  @derive [Poison.Encoder]
  defstruct [
    :mpn,
    :serviceName,
    :name,
    :minimumQuantity,
    :maximumQuantity,
    :prices,
    :billingPeriod,
    :dependsOn
  ]

  @type t :: %__MODULE__{
          :mpn => String.t() | nil,
          :serviceName => String.t() | nil,
          :name => String.t(),
          :minimumQuantity => String.t(),
          :maximumQuantity => String.t(),
          :prices => [ProductPrice],
          :billingPeriod => ProductBillingPeriod | nil,
          :dependsOn => [DependsOnItems] | nil
        }
end

defimpl Poison.Decoder, for: Ingram.Marketplace.Model.Product do
  import Ingram.Marketplace.Deserializer

  def decode(value, options) do
    value
    |> deserialize(:prices, :list, Ingram.Marketplace.Model.ProductPrice, options)
    |> deserialize(
      :billingPeriod,
      :struct,
      Ingram.Marketplace.Model.ProductBillingPeriod,
      options
    )
    |> deserialize(:dependsOn, :list, Ingram.Marketplace.Model.DependsOnItems, options)
  end
end
