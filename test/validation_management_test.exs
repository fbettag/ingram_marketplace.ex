defmodule Multicloud.Ingram.ValidationManagementTest do
  use ExUnit.Case
  alias Ingram.Marketplace.Model
  alias Ingram.Marketplace.{CustomerManagement, ValidationManagement}

  test "Validation Management" do
    customer = TestHelper.customer_factory()

    assert {:ok, %Model.GetCustomerDetails{} = customer} =
             CustomerManagement.create_customer(customer)

    params = %Model.ValidationParameters{
      customerId: customer.id,
      products: [
        %Model.ValidationParametersItem{
          mpn: "aaaaaaaa-aaaa-ffff-ffff-ffffffffffff",
          parameters: [
            %Model.ValidationParameter{
              name: "domain",
              value: "example.com"
            }
          ]
        }
      ]
    }

    assert {:ok, %Model.ValidationParametersResult{} = _data} =
             ValidationManagement.validation_parameters_post(params)
  end
end
