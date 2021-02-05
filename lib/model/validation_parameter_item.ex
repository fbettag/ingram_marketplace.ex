defmodule Ingram.Marketplace.Model.ValidationParameterItem do
  @moduledoc """
  The structure representing an individual product parameter items.
  """

  @derive [Poison.Encoder]
  defstruct [
    :name,
    :result,
    :message
  ]

  @type t :: %__MODULE__{
          :name => String.t() | nil,
          :result => String.t() | nil,
          :message => String.t() | nil
        }
end

defimpl Poison.Decoder, for: Ingram.Marketplace.Model.ValidationParameterItem do
  def decode(value, _options) do
    value
  end
end
