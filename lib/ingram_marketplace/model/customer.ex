defmodule Ingram.Marketplace.Model.Customer do
  @moduledoc """
  A customer representation that contains the basic information about the customer such as the identifier, name, type, status, and billing mode.
  """

  @derive [Poison.Encoder]
  defstruct [
    :id,
    :externalId,
    :name,
    :status,
    :address,
    :contactPersons,
    :language
  ]

  @type t :: %__MODULE__{
          :id => String.t(),
          :externalId => String.t(),
          :name => String.t(),
          :status => String.t(),
          :address => Address | nil,
          :contactPersons => [GetContactPerson] | nil,
          :language => String.t() | nil
        }
end

defimpl Poison.Decoder, for: Ingram.Marketplace.Model.Customer do
  import Ingram.Marketplace.Deserializer

  def decode(value, options) do
    value
    |> deserialize(:address, :struct, Ingram.Marketplace.Model.Address, options)
    |> deserialize(:contactPersons, :list, Ingram.Marketplace.Model.GetContactPerson, options)
  end
end
