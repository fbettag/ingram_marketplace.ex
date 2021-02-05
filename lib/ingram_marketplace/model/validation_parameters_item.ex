defmodule Ingram.Marketplace.Model.ValidationParametersItem do
  @moduledoc """
  The structure representing an individual product parameter.
  """

  @derive [Poison.Encoder]
  defstruct [
    :mpn,
    :parameters
  ]

  @type t :: %__MODULE__{
          :mpn => String.t() | nil,
          :parameters => [ValidationParameter] | nil
        }
end

defimpl Poison.Decoder, for: Ingram.Marketplace.Model.ValidationParametersItem do
  import Ingram.Marketplace.Deserializer

  def decode(value, options) do
    value
    |> deserialize(:parameters, :list, Ingram.Marketplace.Model.ValidationParameter, options)
  end
end
