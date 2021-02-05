defmodule Ingram.Marketplace.Model.ValidationParameter do
  @moduledoc """
  The structure representing an individual product parameter. It specifies the parameter name and its value that can be any of the following types: string, number, boolean, array, or object.
  """

  @derive [Poison.Encoder]
  defstruct [
    :name,
    :value
  ]

  @type t :: %__MODULE__{
          :name => String.t() | nil,
          :value => OneOfstringbooleannumberobjectarray | nil
        }
end

defimpl Poison.Decoder, for: Ingram.Marketplace.Model.ValidationParameter do
  import Ingram.Marketplace.Deserializer

  def decode(value, options) do
    value
    |> deserialize(
      :value,
      :struct,
      Ingram.Marketplace.Model.OneOfstringbooleannumberobjectarray,
      options
    )
  end
end
