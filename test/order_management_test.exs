defmodule Multicloud.Ingram.OrderManagementTest do
  use ExUnit.Case
  alias Ingram.Marketplace.Model
  alias Ingram.Marketplace.{CustomerManagement, OrderManagement}

  test "Order Management" do
    customer = TestHelper.customer_factory()

    assert {:ok, %Model.GetCustomerDetails{} = customer} =
             CustomerManagement.create_customer(customer)

    estimate = %Model.OrderEstimationRequest{
      type: "sales",
      customerId: customer.id,
      products: [
        %Model.OrderProductToEstimation{
          mpn: "aaaaaaaa-aaaa-ffff-ffff-ffffffffffff",
          quantity: 1
        }
      ]
    }

    assert {:ok, %Model.OrderEstimationDetails{} = _estimation} =
             OrderManagement.estimate_order(estimate)

    order = %Model.OrderDetails{
      poNumber: "#{:rand.uniform(1_000_000)}",
      products: [
        %Model.OrderProduct{
          mpn: "aaaaaaaa-aaaa-ffff-ffff-ffffffffffff",
          quantity: 1
          # parameters: [
          #  %Model.ProductParameter{
          #    name: "",
          #    value: false
          #  }
          # ]
        }
      ],
      type: "sales",
      customerId: customer.id
    }

    assert {:ok, %Model.Order{} = ordered} = OrderManagement.create_order(order)

    assert {:ok, %Model.OrderDetailsWithPrices{} = _details} =
             OrderManagement.get_order_details(ordered.id)

    assert {:ok, %{:data => orders}} =
             OrderManagement.get_orders(customerId: customer.id, limit: 1000)

    assert Enum.any?(orders, fn order -> order.id == ordered.id end)
  end
end
