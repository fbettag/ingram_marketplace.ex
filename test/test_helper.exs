ExUnit.start()

{:ok, _} = Ingram.Marketplace.Auth.start_link()

defmodule TestHelper do
  alias Ingram.Marketplace.Model

  def customer_factory,
    do: %Model.PostCustomerDetails{
      taxRegId: "DE1234567",
      contactPersons: [
        %Model.PostContactPerson{
          type: "admin",
          firstName: "James",
          lastName: "Jonkers",
          email: "james@jonkers.org",
          phoneNumber: "+49123456789",
          login: "foo#{:rand.uniform(300_000)}",
          password: "foo#{:rand.uniform(300_000)}"
        }
      ],
      externalId: "#{:rand.uniform(200_000)}",
      name: "Foo Customer",
      status: "active",
      address: %Model.Address{
        streetAddress: "Foobar Strasse 123",
        addressExtension: "Apartment 420",
        postalCode: "12345",
        city: "Somewhere",
        state: "Bayern",
        countryCode: "DE"
      },
      language: "DE"
    }
end
