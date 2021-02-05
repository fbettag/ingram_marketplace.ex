defmodule Ingram.Marketplace.Model.InlineResponse2002 do
  @moduledoc """
  Generic InlineResponse of a 200 used by `OrderManagement`.
  """

  @derive [Poison.Encoder]
  defstruct [
    :data
  ]

  @type t :: %__MODULE__{
          :data => [Ingram.Marketplace.Model.Order] | nil
        }
end

defimpl Poison.Decoder, for: Ingram.Marketplace.Model.InlineResponse2002 do
  import Ingram.Marketplace.Deserializer

  def decode(value, options) do
    value
    |> deserialize(:data, :list, Ingram.Marketplace.Model.Order, options)
  end
end
