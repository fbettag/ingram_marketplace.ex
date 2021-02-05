defmodule Multicloud.Ingram.ReportManagementTest do
  use ExUnit.Case
  alias Ingram.Marketplace.ReportManagement
  alias Ingram.Marketplace.Model

  test "Report Management" do
    assert {:ok, %{:data => data}} = ReportManagement.get_reports()
    id = Enum.at(data, 0).id
    assert {:ok, %Model.ReportItem{}} = ReportManagement.get_report_by_id(id)
  end
end
