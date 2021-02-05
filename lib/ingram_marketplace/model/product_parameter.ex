defmodule Ingram.Marketplace.Model.ProductParameter do
  @moduledoc """
  The structure representing a product activation parameter.
  """

  @derive [Poison.Encoder]
  defstruct [
    :name,
    :value
  ]

  @type t :: %__MODULE__{
          :name => String.t() | nil,
          :value => OneOfstringnumberbooleanobjectarray | nil
        }
end

defimpl Poison.Decoder, for: Ingram.Marketplace.Model.ProductParameter do
  import Ingram.Marketplace.Deserializer

  def decode(value, options) do
    value
    |> deserialize(
      :value,
      :struct,
      Ingram.Marketplace.Model.OneOfstringnumberbooleanobjectarray,
      options
    )
  end
end
