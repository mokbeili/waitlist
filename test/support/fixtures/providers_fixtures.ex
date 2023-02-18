defmodule Waitlist.ProvidersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Waitlist.Providers` context.
  """

  @doc """
  Generate a provider.
  """
  def provider_fixture(attrs \\ %{}) do
    {:ok, provider} =
      attrs
      |> Enum.into(%{
        licensed: true,
        name: "some name"
      })
      |> Waitlist.Providers.create_provider()

    provider
  end
end
