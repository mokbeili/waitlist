defmodule Waitlist.LocationParticipantsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Waitlist.LocationParticipants` context.
  """

  @doc """
  Generate a location_participant.
  """
  def location_participant_fixture(attrs \\ %{}) do
    {:ok, location_participant} =
      attrs
      |> Enum.into(%{
        added_at: 42,
        type: :waitlist
      })
      |> Waitlist.LocationParticipants.create_location_participant()

    location_participant
  end
end
