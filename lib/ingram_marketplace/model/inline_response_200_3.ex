defmodule Ingram.Marketplace.Model.InlineResponse2003 do
  @moduledoc """
  Generic InlineResponse of a 200 used by `SubscriptionManagement`.
  """

  @derive [Poison.Encoder]
  defstruct [
    :data
  ]

  @type t :: %__MODULE__{
          :data => [Subscription] | nil
        }
end

defimpl Poison.Decoder, for: Ingram.Marketplace.Model.InlineResponse2003 do
  import Ingram.Marketplace.Deserializer

  def decode(value, options) do
    value
    |> deserialize(:data, :list, Ingram.Marketplace.Model.Subscription, options)
  end
end
