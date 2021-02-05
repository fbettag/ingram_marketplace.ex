defmodule Ingram.Marketplace.Model.ValidationParameters do
  @moduledoc """
  List of product-specific activation parameters.
  """

  @derive [Poison.Encoder]
  defstruct [
    :customerId,
    :products
  ]

  @type t :: %__MODULE__{
          :customerId => String.t(),
          :products => [ValidationParametersItem]
        }
end

defimpl Poison.Decoder, for: Ingram.Marketplace.Model.ValidationParameters do
  import Ingram.Marketplace.Deserializer

  def decode(value, options) do
    value
    |> deserialize(:products, :list, Ingram.Marketplace.Model.ValidationParametersItem, options)
  end
end
