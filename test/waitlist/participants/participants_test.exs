defmodule Waitlist.Participants.ParticipantsTest do
  use Waitlist.DataCase

  alias Waitlist.Participants.Participants

  describe "participants" do
    alias Waitlist.Participants.Participants.Participant

    import Waitlist.Participants.ParticipantsFixtures

    @invalid_attrs %{date_of_birth: nil, first_name: nil, last_name: nil, middle_name: nil}

    test "list_participants/0 returns all participants" do
      participant = participant_fixture()
      assert Participants.list_participants() == [participant]
    end

    test "get_participant!/1 returns the participant with given id" do
      participant = participant_fixture()
      assert Participants.get_participant!(participant.id) == participant
    end

    test "create_participant/1 with valid data creates a participant" do
      valid_attrs = %{date_of_birth: ~D[2023-02-17], first_name: "some first_name", last_name: "some last_name", middle_name: "some middle_name"}

      assert {:ok, %Participant{} = participant} = Participants.create_participant(valid_attrs)
      assert participant.date_of_birth == ~D[2023-02-17]
      assert participant.first_name == "some first_name"
      assert participant.last_name == "some last_name"
      assert participant.middle_name == "some middle_name"
    end

    test "create_participant/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Participants.create_participant(@invalid_attrs)
    end

    test "update_participant/2 with valid data updates the participant" do
      participant = participant_fixture()
      update_attrs = %{date_of_birth: ~D[2023-02-18], first_name: "some updated first_name", last_name: "some updated last_name", middle_name: "some updated middle_name"}

      assert {:ok, %Participant{} = participant} = Participants.update_participant(participant, update_attrs)
      assert participant.date_of_birth == ~D[2023-02-18]
      assert participant.first_name == "some updated first_name"
      assert participant.last_name == "some updated last_name"
      assert participant.middle_name == "some updated middle_name"
    end

    test "update_participant/2 with invalid data returns error changeset" do
      participant = participant_fixture()
      assert {:error, %Ecto.Changeset{}} = Participants.update_participant(participant, @invalid_attrs)
      assert participant == Participants.get_participant!(participant.id)
    end

    test "delete_participant/1 deletes the participant" do
      participant = participant_fixture()
      assert {:ok, %Participant{}} = Participants.delete_participant(participant)
      assert_raise Ecto.NoResultsError, fn -> Participants.get_participant!(participant.id) end
    end

    test "change_participant/1 returns a participant changeset" do
      participant = participant_fixture()
      assert %Ecto.Changeset{} = Participants.change_participant(participant)
    end
  end
end
