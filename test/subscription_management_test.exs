defmodule Multicloud.Ingram.SubscriptionManagementTest do
  use ExUnit.Case
  alias Ingram.Marketplace.SubscriptionManagement
  alias Ingram.Marketplace.Model

  test "Subscription Management" do
    assert {:ok, %{:data => data}} = SubscriptionManagement.get_subscriptions()

    id = Enum.at(data, 0).id

    assert {:ok, %Model.SubscriptionDetails{} = subscription} =
             SubscriptionManagement.get_subscription(id)
  end
end
