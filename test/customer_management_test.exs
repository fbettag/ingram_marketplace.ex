defmodule Multicloud.Ingram.CustomerManagementTest do
  use ExUnit.Case
  alias Ingram.Marketplace.CustomerManagement
  alias Ingram.Marketplace.Model

  test "Customer Management" do
    customer = TestHelper.customer_factory()

    assert {:ok, %Model.GetCustomerDetails{} = data} =
             CustomerManagement.create_customer(customer)

    compare(customer, data)

    assert {:ok, %Model.GetCustomerDetails{} = data} =
             CustomerManagement.get_customer_by_id(data.id)

    compare(customer, data)

    assert {:ok, %{:data => customers}} =
             CustomerManagement.get_customers(externalId: customer.externalId, limit: 1000)

    assert Enum.any?(customers, fn data -> data.externalId == customer.externalId end)
  end

  defp compare(customer, data) do
    assert customer.taxRegId == data.taxRegId
    assert customer.externalId == data.externalId
    assert customer.name == data.name
    assert customer.status == data.status
    assert customer.language == data.language

    assert customer.address.streetAddress == data.address.streetAddress
    assert customer.address.addressExtension == data.address.addressExtension
    assert customer.address.postalCode == data.address.postalCode
    assert customer.address.city == data.address.city
    assert customer.address.state == data.address.state
    assert customer.address.countryCode == data.address.countryCode

    assert Enum.at(customer.contactPersons, 0).type == Enum.at(data.contactPersons, 0).type

    assert Enum.at(customer.contactPersons, 0).firstName ==
             Enum.at(data.contactPersons, 0).firstName

    assert Enum.at(customer.contactPersons, 0).lastName ==
             Enum.at(data.contactPersons, 0).lastName

    assert Enum.at(customer.contactPersons, 0).email == Enum.at(data.contactPersons, 0).email

    assert Enum.at(customer.contactPersons, 0).phoneNumber ==
             Enum.at(data.contactPersons, 0).phoneNumber
  end
end
