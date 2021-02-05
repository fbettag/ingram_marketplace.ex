defmodule Ingram.Marketplace.Model.InlineResponse2001 do
  @moduledoc """
  Generic InlineResponse of a 200 used by `ProductCatalog`.
  """

  @derive [Poison.Encoder]
  defstruct [
    :data,
    :pagination
  ]

  @type t :: %__MODULE__{
          :data => [Product] | nil,
          :pagination => Pagination | nil
        }
end

defimpl Poison.Decoder, for: Ingram.Marketplace.Model.InlineResponse2001 do
  import Ingram.Marketplace.Deserializer

  def decode(value, options) do
    value
    |> deserialize(:data, :list, Ingram.Marketplace.Model.Product, options)
    |> deserialize(:pagination, :struct, Ingram.Marketplace.Model.Pagination, options)
  end
end
