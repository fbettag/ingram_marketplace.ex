defmodule Ingram.Marketplace.Model.GetCustomerDetails do
  @moduledoc """
  The extended representation of a specific customer with additional arrays of addresses and contacts, and the preferred language of the customer.
  """

  @derive [Poison.Encoder]
  defstruct [
    :taxRegId,
    :id,
    :externalId,
    :name,
    :status,
    :address,
    :contactPersons,
    :language
  ]

  @type t :: %__MODULE__{
          :taxRegId => String.t() | nil,
          :id => String.t(),
          :externalId => String.t(),
          :name => String.t(),
          :status => String.t(),
          :address => Address,
          :contactPersons => [GetContactPerson],
          :language => String.t() | nil
        }
end

defimpl Poison.Decoder, for: Ingram.Marketplace.Model.GetCustomerDetails do
  import Ingram.Marketplace.Deserializer

  def decode(value, options) do
    value
    |> deserialize(:address, :struct, Ingram.Marketplace.Model.Address, options)
    |> deserialize(:contactPersons, :list, Ingram.Marketplace.Model.GetContactPerson, options)
  end
end
