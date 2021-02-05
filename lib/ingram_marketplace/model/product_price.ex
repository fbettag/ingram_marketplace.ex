defmodule Ingram.Marketplace.Model.ProductPrice do
  @moduledoc """
  A structure representing the product price.
  """

  @derive [Poison.Encoder]
  defstruct [
    :amount,
    :currency,
    :type
  ]

  @type t :: %__MODULE__{
          :amount => String.t(),
          :currency => String.t(),
          :type => String.t() | nil
        }
end

defimpl Poison.Decoder, for: Ingram.Marketplace.Model.ProductPrice do
  def decode(value, _options) do
    value
  end
end
