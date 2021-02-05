defmodule Ingram.Marketplace.Model.InlineResponse2004 do
  @moduledoc """
  Generic InlineResponse of a 200 used by `ReportManagement`.
  """

  @derive [Poison.Encoder]
  defstruct [
    :data
  ]

  @type t :: %__MODULE__{
          :data => [Ingram.Marketplace.Model.ReportItem] | nil
        }
end

defimpl Poison.Decoder, for: Ingram.Marketplace.Model.InlineResponse2004 do
  import Ingram.Marketplace.Deserializer

  def decode(value, options) do
    value
    |> deserialize(:data, :list, Ingram.Marketplace.Model.ReportItem, options)
  end
end
