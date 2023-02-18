defmodule Waitlist.AddressesTest do
  use Waitlist.DataCase

  alias Waitlist.Addresses

  describe "addresses" do
    alias Waitlist.Addresses.Address

    import Waitlist.AddressesFixtures

    @invalid_attrs %{city: nil, latitude: nil, lineOne: nil, lineTwo: nil, longitude: nil, postalCode: nil, province: nil, unit: nil}

    test "list_addresses/0 returns all addresses" do
      address = address_fixture()
      assert Addresses.list_addresses() == [address]
    end

    test "get_address!/1 returns the address with given id" do
      address = address_fixture()
      assert Addresses.get_address!(address.id) == address
    end

    test "create_address/1 with valid data creates a address" do
      valid_attrs = %{city: "some city", latitude: 120.5, lineOne: "some lineOne", lineTwo: "some lineTwo", longitude: 120.5, postalCode: "some postalCode", province: "some province", unit: "some unit"}

      assert {:ok, %Address{} = address} = Addresses.create_address(valid_attrs)
      assert address.city == "some city"
      assert address.latitude == 120.5
      assert address.lineOne == "some lineOne"
      assert address.lineTwo == "some lineTwo"
      assert address.longitude == 120.5
      assert address.postalCode == "some postalCode"
      assert address.province == "some province"
      assert address.unit == "some unit"
    end

    test "create_address/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Addresses.create_address(@invalid_attrs)
    end

    test "update_address/2 with valid data updates the address" do
      address = address_fixture()
      update_attrs = %{city: "some updated city", latitude: 456.7, lineOne: "some updated lineOne", lineTwo: "some updated lineTwo", longitude: 456.7, postalCode: "some updated postalCode", province: "some updated province", unit: "some updated unit"}

      assert {:ok, %Address{} = address} = Addresses.update_address(address, update_attrs)
      assert address.city == "some updated city"
      assert address.latitude == 456.7
      assert address.lineOne == "some updated lineOne"
      assert address.lineTwo == "some updated lineTwo"
      assert address.longitude == 456.7
      assert address.postalCode == "some updated postalCode"
      assert address.province == "some updated province"
      assert address.unit == "some updated unit"
    end

    test "update_address/2 with invalid data returns error changeset" do
      address = address_fixture()
      assert {:error, %Ecto.Changeset{}} = Addresses.update_address(address, @invalid_attrs)
      assert address == Addresses.get_address!(address.id)
    end

    test "delete_address/1 deletes the address" do
      address = address_fixture()
      assert {:ok, %Address{}} = Addresses.delete_address(address)
      assert_raise Ecto.NoResultsError, fn -> Addresses.get_address!(address.id) end
    end

    test "change_address/1 returns a address changeset" do
      address = address_fixture()
      assert %Ecto.Changeset{} = Addresses.change_address(address)
    end
  end
end
