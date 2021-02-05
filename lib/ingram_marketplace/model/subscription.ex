defmodule Ingram.Marketplace.Model.Subscription do
  @moduledoc """
  The representation of a subscription created when an order to a product is processed.
  """

  @derive [Poison.Encoder]
  defstruct [
    :id,
    :customerId,
    :status,
    :renewalStatus,
    :creationDate,
    :renewalDate,
    :lastModifiedDate
  ]

  @type t :: %__MODULE__{
          :id => String.t(),
          :customerId => String.t() | nil,
          :status => String.t() | nil,
          :renewalStatus => boolean() | nil,
          :creationDate => Date.t() | nil,
          :renewalDate => Date.t() | nil,
          :lastModifiedDate => Date.t() | nil
        }
end

defimpl Poison.Decoder, for: Ingram.Marketplace.Model.Subscription do
  import Ingram.Marketplace.Deserializer

  def decode(value, options) do
    value
    |> deserialize(:creationDate, :date, nil, options)
    |> deserialize(:renewalDate, :date, nil, options)
    |> deserialize(:lastModifiedDate, :date, nil, options)
  end
end
