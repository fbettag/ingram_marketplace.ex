defmodule Multicloud.Ingram.ProductCatalogTest do
  use ExUnit.Case
  alias Ingram.Marketplace.ProductCatalog

  test "Product Catalog" do
    assert {:ok, %{:data => data}} = ProductCatalog.get_catalog()
    refute Enum.empty?(data)
  end
end
