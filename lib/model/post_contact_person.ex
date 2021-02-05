defmodule Ingram.Marketplace.Model.PostContactPerson do
  @moduledoc """
  Contact information about a physical person. This can be used in notifications and displayed when the person logs in to the user panels. When providing a service for a user, the respective cloud application may require this data.
  """

  @derive [Poison.Encoder]
  defstruct [
    :type,
    :firstName,
    :lastName,
    :email,
    :phoneNumber,
    :login,
    :password
  ]

  @type t :: %__MODULE__{
          :type => String.t(),
          :firstName => String.t(),
          :lastName => String.t(),
          :email => String.t(),
          :phoneNumber => String.t(),
          :login => String.t() | nil,
          :password => String.t() | nil
        }
end

defimpl Poison.Decoder, for: Ingram.Marketplace.Model.PostContactPerson do
  def decode(value, _options) do
    value
  end
end
