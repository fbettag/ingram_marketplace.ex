defmodule Ingram.Marketplace.ReportManagement do
  @moduledoc """
  API calls for all endpoints tagged `ReportManagement`.
  """
  import Ingram.Marketplace.RequestBuilder
  alias Ingram.Marketplace.Connection
  alias Ingram.Marketplace.Model

  @doc """
  Get full details of a report
  Get extended details about a report in the platform.

  ## Parameters

  - id (String.t): The ID of the report to be processed by the request.
  - opts (KeywordList): [optional] Optional parameters
  - connection (Ingram.Marketplace.Connection): Connection to server
  ## Returns

  {:ok, %Ingram.Marketplace.Model.ReportItem{}} on success
  {:error, info} on failure
  """
  @spec get_report_by_id(String.t(), keyword(), Tesla.Env.client() | nil) ::
          {:ok, Model.ReportItem.t()} | {:error, Tesla.Env.t()}
  def get_report_by_id(id, _opts \\ [], connection \\ Connection.new()) do
    %{}
    |> method(:get)
    |> url("/reports/#{id}")
    |> Enum.into([])
    |> (&Tesla.request(connection, &1)).()
    |> evaluate_response([
      {200, %Model.ReportItem{}},
      {400, %Model.ErrorMessage{}},
      {403, %Model.ErrorMessage{}},
      {404, %Model.ErrorMessage{}},
      {500, %Model.ErrorMessage{}}
    ])
  end

  @doc """
  Retrieve a list of exported reports
  Get a list of the reseller's rated data reports exported during the specified period.

  ## Parameters

  - opts (KeywordList): [optional] Optional parameters
    - :limit (integer()): The number of items to return.
    - :offset (integer()): The number of items to skip before starting to collect the result set.
    - :name (String.t): The name of the requested reports.
    - :format (String.t): The format filter of the requested reports. Available types:   * `json`   * `xml`   * `csv`   * `xlsx`
    - :status (String.t): The status filter of the requested reports. Available types:   * `submitted`   * `processing`   * `completed`   * `error`
    - :type (String.t): The type filter of the requested reports. Available types:   * `periodic`   * `daily`   * `monthly`   * `onetime`   * `on_invoice`
    - :from (Date.t): The first day of the requested period.
    - :to (Date.t): The last day of the requested period.
  - connection (Ingram.Marketplace.Connection): Connection to server
  ## Returns

  {:ok, %Ingram.Marketplace.Model.InlineResponse2004{}} on success
  {:error, info} on failure
  """
  @spec get_reports(keyword(), Tesla.Env.client() | nil) ::
          {:ok, Model.InlineResponse2004.t()} | {:error, Tesla.Env.t()}
  def get_reports(opts \\ [], connection \\ Connection.new()) do
    optional_params = %{
      :limit => :query,
      :offset => :query,
      :name => :query,
      :format => :query,
      :status => :query,
      :type => :query,
      :creationDateFrom => :query,
      :creationDateTo => :query
    }

    %{}
    |> method(:get)
    |> url("/reports")
    |> add_optional_params(optional_params, opts)
    |> Enum.into([])
    |> (&Tesla.request(connection, &1)).()
    |> evaluate_response([
      {200, %Model.InlineResponse2004{}},
      {403, %Model.ErrorMessage{}},
      {500, %Model.ErrorMessage{}}
    ])
  end
end
