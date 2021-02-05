defmodule Ingram.Marketplace.Model.Order do
  @moduledoc """
  The representation of a specific order that contains high level data of a request to purchase one or more product items. In the platform, the order is extended with an array of *orderLineItem* objects that contain detailed information about each ordered product.
  """

  @derive [Poison.Encoder]
  defstruct [
    :id,
    :type,
    :customerId,
    :creationDate,
    :status
  ]

  @type t :: %__MODULE__{
          :id => String.t(),
          :type => String.t() | nil,
          :customerId => String.t(),
          :creationDate => DateTime.t(),
          :status => String.t()
        }
end

defimpl Poison.Decoder, for: Ingram.Marketplace.Model.Order do
  def decode(value, _options) do
    value
  end
end
