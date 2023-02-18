defmodule Waitlist.LocationParticipantsTest do
  use Waitlist.DataCase

  alias Waitlist.LocationParticipants

  describe "location_participants" do
    alias Waitlist.LocationParticipants.LocationParticipant

    import Waitlist.LocationParticipantsFixtures

    @invalid_attrs %{added_at: nil, type: nil}

    test "list_location_participants/0 returns all location_participants" do
      location_participant = location_participant_fixture()
      assert LocationParticipants.list_location_participants() == [location_participant]
    end

    test "get_location_participant!/1 returns the location_participant with given id" do
      location_participant = location_participant_fixture()
      assert LocationParticipants.get_location_participant!(location_participant.id) == location_participant
    end

    test "create_location_participant/1 with valid data creates a location_participant" do
      valid_attrs = %{added_at: 42, type: :waitlist}

      assert {:ok, %LocationParticipant{} = location_participant} = LocationParticipants.create_location_participant(valid_attrs)
      assert location_participant.added_at == 42
      assert location_participant.type == :waitlist
    end

    test "create_location_participant/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = LocationParticipants.create_location_participant(@invalid_attrs)
    end

    test "update_location_participant/2 with valid data updates the location_participant" do
      location_participant = location_participant_fixture()
      update_attrs = %{added_at: 43, type: :active}

      assert {:ok, %LocationParticipant{} = location_participant} = LocationParticipants.update_location_participant(location_participant, update_attrs)
      assert location_participant.added_at == 43
      assert location_participant.type == :active
    end

    test "update_location_participant/2 with invalid data returns error changeset" do
      location_participant = location_participant_fixture()
      assert {:error, %Ecto.Changeset{}} = LocationParticipants.update_location_participant(location_participant, @invalid_attrs)
      assert location_participant == LocationParticipants.get_location_participant!(location_participant.id)
    end

    test "delete_location_participant/1 deletes the location_participant" do
      location_participant = location_participant_fixture()
      assert {:ok, %LocationParticipant{}} = LocationParticipants.delete_location_participant(location_participant)
      assert_raise Ecto.NoResultsError, fn -> LocationParticipants.get_location_participant!(location_participant.id) end
    end

    test "change_location_participant/1 returns a location_participant changeset" do
      location_participant = location_participant_fixture()
      assert %Ecto.Changeset{} = LocationParticipants.change_location_participant(location_participant)
    end
  end
end
