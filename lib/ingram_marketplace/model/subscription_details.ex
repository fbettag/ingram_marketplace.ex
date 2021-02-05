defmodule Ingram.Marketplace.Model.SubscriptionDetails do
  @moduledoc """
  The representation of a specific subscription created when an order for products is processed.
  """

  @derive [Poison.Encoder]
  defstruct [
    :totalPrice,
    :products,
    :id,
    :customerId,
    :status,
    :renewalStatus,
    :creationDate,
    :renewalDate,
    :lastModifiedDate
  ]

  @type t :: %__MODULE__{
          :totalPrice => Map | nil,
          :products => [SubscriptionItem],
          :id => String.t(),
          :customerId => String.t() | nil,
          :status => String.t() | nil,
          :renewalStatus => boolean() | nil,
          :creationDate => Date.t() | nil,
          :renewalDate => Date.t() | nil,
          :lastModifiedDate => Date.t() | nil
        }
end

defimpl Poison.Decoder, for: Ingram.Marketplace.Model.SubscriptionDetails do
  import Ingram.Marketplace.Deserializer

  def decode(value, options) do
    value
    |> deserialize(:products, :list, Ingram.Marketplace.Model.SubscriptionItem, options)
    |> deserialize(:creationDate, :date, nil, options)
    |> deserialize(:renewalDate, :date, nil, options)
    |> deserialize(:lastModifiedDate, :date, nil, options)
  end
end
