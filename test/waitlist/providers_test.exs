defmodule Waitlist.ProvidersTest do
  use Waitlist.DataCase

  alias Waitlist.Providers

  describe "providers" do
    alias Waitlist.Providers.Provider

    import Waitlist.ProvidersFixtures

    @invalid_attrs %{licensed: nil, name: nil}

    test "list_providers/0 returns all providers" do
      provider = provider_fixture()
      assert Providers.list_providers() == [provider]
    end

    test "get_provider!/1 returns the provider with given id" do
      provider = provider_fixture()
      assert Providers.get_provider!(provider.id) == provider
    end

    test "create_provider/1 with valid data creates a provider" do
      valid_attrs = %{licensed: true, name: "some name"}

      assert {:ok, %Provider{} = provider} = Providers.create_provider(valid_attrs)
      assert provider.licensed == true
      assert provider.name == "some name"
    end

    test "create_provider/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Providers.create_provider(@invalid_attrs)
    end

    test "update_provider/2 with valid data updates the provider" do
      provider = provider_fixture()
      update_attrs = %{licensed: false, name: "some updated name"}

      assert {:ok, %Provider{} = provider} = Providers.update_provider(provider, update_attrs)
      assert provider.licensed == false
      assert provider.name == "some updated name"
    end

    test "update_provider/2 with invalid data returns error changeset" do
      provider = provider_fixture()
      assert {:error, %Ecto.Changeset{}} = Providers.update_provider(provider, @invalid_attrs)
      assert provider == Providers.get_provider!(provider.id)
    end

    test "delete_provider/1 deletes the provider" do
      provider = provider_fixture()
      assert {:ok, %Provider{}} = Providers.delete_provider(provider)
      assert_raise Ecto.NoResultsError, fn -> Providers.get_provider!(provider.id) end
    end

    test "change_provider/1 returns a provider changeset" do
      provider = provider_fixture()
      assert %Ecto.Changeset{} = Providers.change_provider(provider)
    end
  end
end
