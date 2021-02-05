defmodule Ingram.Marketplace.Model.InlineResponse200 do
  @moduledoc """
  Generic InlineResponse of a 200 used by `CustomerManagement`.
  """

  @derive [Poison.Encoder]
  defstruct [
    :data,
    :pagination
  ]

  @type t :: %__MODULE__{
          :data => [Customer] | nil,
          :pagination => Pagination | nil
        }
end

defimpl Poison.Decoder, for: Ingram.Marketplace.Model.InlineResponse200 do
  import Ingram.Marketplace.Deserializer

  def decode(value, options) do
    value
    |> deserialize(:data, :list, Ingram.Marketplace.Model.Customer, options)
    |> deserialize(:pagination, :struct, Ingram.Marketplace.Model.Pagination, options)
  end
end
