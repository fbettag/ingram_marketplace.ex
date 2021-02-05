defmodule Ingram.Marketplace.Model.ProductBillingPeriod do
  @moduledoc """
  The structure representing a product billing period.
  """

  @derive [Poison.Encoder]
  defstruct [
    :type,
    :duration
  ]

  @type t :: %__MODULE__{
          :type => String.t() | nil,
          :duration => integer() | nil
        }
end

defimpl Poison.Decoder, for: Ingram.Marketplace.Model.ProductBillingPeriod do
  def decode(value, _options) do
    value
  end
end
