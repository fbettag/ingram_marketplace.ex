defmodule Ingram.Marketplace.Model.OrderDetails do
  @moduledoc """
  The extended representation of a specific order with additional information about the ordered items.
  """

  @derive [Poison.Encoder]
  defstruct [
    :poNumber,
    :products,
    :id,
    :type,
    :customerId,
    :creationDate,
    :status
  ]

  @type t :: %__MODULE__{
          :poNumber => String.t() | nil,
          :products => [OrderProduct],
          :id => String.t(),
          :type => String.t() | nil,
          :customerId => String.t(),
          :creationDate => DateTime.t(),
          :status => String.t()
        }
end

defimpl Poison.Decoder, for: Ingram.Marketplace.Model.OrderDetails do
  import Ingram.Marketplace.Deserializer

  def decode(value, options) do
    value
    |> deserialize(:products, :list, Ingram.Marketplace.Model.OrderProduct, options)
  end
end
