defmodule Waitlist.Providers.LocationsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Waitlist.Providers.Locations` context.
  """

  @doc """
  Generate a location.
  """
  def location_fixture(attrs \\ %{}) do
    {:ok, location} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Waitlist.Providers.Locations.create_location()

    location
  end
end
