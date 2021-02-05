defmodule Ingram.Marketplace.Model.ValidationParametersResult do
  @moduledoc """
  The result of validation of the product-specific activation parameters.
  """

  @derive [Poison.Encoder]
  defstruct [
    :data
  ]

  @type t :: %__MODULE__{
          :data => [ValidationParameterItem] | nil
        }
end

defimpl Poison.Decoder, for: Ingram.Marketplace.Model.ValidationParametersResult do
  import Ingram.Marketplace.Deserializer

  def decode(value, options) do
    value
    |> deserialize(:data, :list, Ingram.Marketplace.Model.ValidationParameterItem, options)
  end
end
