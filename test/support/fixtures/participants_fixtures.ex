defmodule Waitlist.ParticipantsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Waitlist.Participants` context.
  """

  @doc """
  Generate a guardian.
  """
  def guardian_fixture(attrs \\ %{}) do
    {:ok, guardian} =
      attrs
      |> Enum.into(%{
        date_of_birth: ~D[2023-02-17],
        first_name: "some first_name",
        last_name: "some last_name",
        middle_name: "some middle_name"
      })
      |> Waitlist.Participants.create_guardian()

    guardian
  end
end
