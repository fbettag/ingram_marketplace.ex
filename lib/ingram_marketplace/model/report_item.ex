defmodule Ingram.Marketplace.Model.ReportItem do
  @moduledoc """
  A rated data report generated and exported during a specific period.
  """

  @derive [Poison.Encoder]
  defstruct [
    :id,
    :name,
    :status,
    :type,
    :format,
    :creationDate,
    :startDate,
    :endDate,
    :downloadUrl
  ]

  @type t :: %__MODULE__{
          :id => String.t() | nil,
          :name => String.t() | nil,
          :status => String.t() | nil,
          :type => String.t() | nil,
          :format => String.t() | nil,
          :creationDate => DateTime.t() | nil,
          :startDate => DateTime.t() | nil,
          :endDate => DateTime.t() | nil,
          :downloadUrl => String.t() | nil
        }
end

defimpl Poison.Decoder, for: Ingram.Marketplace.Model.ReportItem do
  def decode(value, _options) do
    value
  end
end
