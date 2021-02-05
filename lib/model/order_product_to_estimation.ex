defmodule Ingram.Marketplace.Model.OrderProductToEstimation do
  @moduledoc """
  The extended representation of a specific order product estimation with information about the price.
  """

  @derive [Poison.Encoder]
  defstruct [
    :mpn,
    :name,
    :quantity,
    :subscriptionId
  ]

  @type t :: %__MODULE__{
          :mpn => String.t() | nil,
          :name => String.t() | nil,
          :quantity => float(),
          :subscriptionId => String.t() | nil
        }
end

defimpl Poison.Decoder, for: Ingram.Marketplace.Model.OrderProductToEstimation do
  def decode(value, _options) do
    value
  end
end
