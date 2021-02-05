defmodule Ingram.Marketplace.Model.ErrorMessage do
  @moduledoc """
  The structure with additional information about the result of the API request.
  """

  @derive [Poison.Encoder]
  defstruct [
    :timeStamp,
    :status,
    :message,
    :path,
    :correlationId
  ]

  @type t :: %__MODULE__{
          :timeStamp => String.t(),
          :status => float(),
          :message => String.t(),
          :path => String.t(),
          :correlationId => String.t()
        }
end

defimpl Poison.Decoder, for: Ingram.Marketplace.Model.ErrorMessage do
  def decode(value, _options) do
    value
  end
end
