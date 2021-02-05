defmodule Ingram.Marketplace.Model.Address do
  @moduledoc """
  The postal address data of a customer used in invoices and displayed when the customer logs in to the user panels. As for cloud services, this information may be required to create a service.
  """

  @derive [Poison.Encoder]
  defstruct [
    :streetAddress,
    :addressExtension,
    :postalCode,
    :city,
    :state,
    :countryCode
  ]

  @type t :: %__MODULE__{
          :streetAddress => String.t(),
          :addressExtension => String.t() | nil,
          :postalCode => String.t(),
          :city => String.t(),
          :state => String.t(),
          :countryCode => String.t()
        }
end

defimpl Poison.Decoder, for: Ingram.Marketplace.Model.Address do
  def decode(value, _options) do
    value
  end
end
