defmodule Ingram.Marketplace.Model.TotalOrderPriceEstimation do
  @moduledoc """
  A structure representing the order total price estimation.
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

defimpl Poison.Decoder, for: Ingram.Marketplace.Model.TotalOrderPriceEstimation do
  def decode(value, _options) do
    value
  end
end
