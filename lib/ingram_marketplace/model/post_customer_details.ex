defmodule Ingram.Marketplace.Model.PostCustomerDetails do
  @moduledoc """
  The extended representation of a specific customer with additional arrays of addresses and contacts, and the preferred language of the customer.
  """

  @derive [Poison.Encoder]
  defstruct [
    :taxRegId,
    :contactPersons,
    :id,
    :externalId,
    :name,
    :status,
    :address,
    :language
  ]

  @type t :: %__MODULE__{
          :taxRegId => String.t() | nil,
          :contactPersons => [PostContactPerson] | nil,
          :id => String.t(),
          :externalId => String.t(),
          :name => String.t(),
          :status => String.t(),
          :address => Address | nil,
          :language => String.t() | nil
        }
end

defimpl Poison.Decoder, for: Ingram.Marketplace.Model.PostCustomerDetails do
  import Ingram.Marketplace.Deserializer

  def decode(value, options) do
    value
    |> deserialize(:contactPersons, :list, Ingram.Marketplace.Model.PostContactPerson, options)
    |> deserialize(:address, :struct, Ingram.Marketplace.Model.Address, options)
  end
end
