defmodule Ingram.Marketplace.Model.OrderProduct do
  @moduledoc """
  The extended representation of a specific order product with basic information about the product.
  """

  @derive [Poison.Encoder]
  defstruct [
    :mpn,
    :name,
    :quantity,
    :subscriptionId,
    :parameters
  ]

  @type t :: %__MODULE__{
          :mpn => String.t() | nil,
          :name => String.t() | nil,
          :quantity => float() | nil,
          :subscriptionId => String.t() | nil,
          :parameters => [ProductParameter] | nil
        }
end

defimpl Poison.Decoder, for: Ingram.Marketplace.Model.OrderProduct do
  import Ingram.Marketplace.Deserializer

  def decode(value, options) do
    value
    |> deserialize(:parameters, :list, Ingram.Marketplace.Model.ProductParameter, options)
  end
end
