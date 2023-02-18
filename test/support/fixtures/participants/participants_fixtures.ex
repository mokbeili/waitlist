defmodule Waitlist.Participants.ParticipantsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Waitlist.Participants.Participants` context.
  """

  @doc """
  Generate a participant.
  """
  def participant_fixture(attrs \\ %{}) do
    {:ok, participant} =
      attrs
      |> Enum.into(%{
        date_of_birth: ~D[2023-02-17],
        first_name: "some first_name",
        last_name: "some last_name",
        middle_name: "some middle_name"
      })
      |> Waitlist.Participants.Participants.create_participant()

    participant
  end
end
