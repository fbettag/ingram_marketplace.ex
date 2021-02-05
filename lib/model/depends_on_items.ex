defmodule Ingram.Marketplace.Model.DependsOnItems do
  @moduledoc """
  A set of product identifiers
  """

  @derive [Poison.Encoder]
  defstruct [
    :mpn
  ]

  @type t :: %__MODULE__{
          :mpn => String.t() | nil
        }
end

defimpl Poison.Decoder, for: Ingram.Marketplace.Model.DependsOnItems do
  def decode(value, _options) do
    value
  end
end
