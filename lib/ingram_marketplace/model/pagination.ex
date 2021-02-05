defmodule Ingram.Marketplace.Model.Pagination do
  @moduledoc """
  The information about the returned results, including the current position of the returned range (offset), total number of items in the returned range (limit), and total number of items in the whole collection (total).
  """

  @derive [Poison.Encoder]
  defstruct [
    :offset,
    :limit,
    :total
  ]

  @type t :: %__MODULE__{
          :offset => float(),
          :limit => float(),
          :total => float()
        }
end

defimpl Poison.Decoder, for: Ingram.Marketplace.Model.Pagination do
  def decode(value, _options) do
    value
  end
end
