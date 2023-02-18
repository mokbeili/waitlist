defmodule Waitlist.AddressesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Waitlist.Addresses` context.
  """

  @doc """
  Generate a address.
  """
  def address_fixture(attrs \\ %{}) do
    {:ok, address} =
      attrs
      |> Enum.into(%{
        city: "some city",
        latitude: 120.5,
        lineOne: "some lineOne",
        lineTwo: "some lineTwo",
        longitude: 120.5,
        postalCode: "some postalCode",
        province: "some province",
        unit: "some unit"
      })
      |> Waitlist.Addresses.create_address()

    address
  end
end
