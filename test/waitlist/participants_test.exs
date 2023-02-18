defmodule Waitlist.ParticipantsTest do
  use Waitlist.DataCase

  alias Waitlist.Participants

  describe "guardians" do
    alias Waitlist.Participants.Guardian

    import Waitlist.ParticipantsFixtures

    @invalid_attrs %{date_of_birth: nil, first_name: nil, last_name: nil, middle_name: nil}

    test "list_guardians/0 returns all guardians" do
      guardian = guardian_fixture()
      assert Participants.list_guardians() == [guardian]
    end

    test "get_guardian!/1 returns the guardian with given id" do
      guardian = guardian_fixture()
      assert Participants.get_guardian!(guardian.id) == guardian
    end

    test "create_guardian/1 with valid data creates a guardian" do
      valid_attrs = %{date_of_birth: ~D[2023-02-17], first_name: "some first_name", last_name: "some last_name", middle_name: "some middle_name"}

      assert {:ok, %Guardian{} = guardian} = Participants.create_guardian(valid_attrs)
      assert guardian.date_of_birth == ~D[2023-02-17]
      assert guardian.first_name == "some first_name"
      assert guardian.last_name == "some last_name"
      assert guardian.middle_name == "some middle_name"
    end

    test "create_guardian/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Participants.create_guardian(@invalid_attrs)
    end

    test "update_guardian/2 with valid data updates the guardian" do
      guardian = guardian_fixture()
      update_attrs = %{date_of_birth: ~D[2023-02-18], first_name: "some updated first_name", last_name: "some updated last_name", middle_name: "some updated middle_name"}

      assert {:ok, %Guardian{} = guardian} = Participants.update_guardian(guardian, update_attrs)
      assert guardian.date_of_birth == ~D[2023-02-18]
      assert guardian.first_name == "some updated first_name"
      assert guardian.last_name == "some updated last_name"
      assert guardian.middle_name == "some updated middle_name"
    end

    test "update_guardian/2 with invalid data returns error changeset" do
      guardian = guardian_fixture()
      assert {:error, %Ecto.Changeset{}} = Participants.update_guardian(guardian, @invalid_attrs)
      assert guardian == Participants.get_guardian!(guardian.id)
    end

    test "delete_guardian/1 deletes the guardian" do
      guardian = guardian_fixture()
      assert {:ok, %Guardian{}} = Participants.delete_guardian(guardian)
      assert_raise Ecto.NoResultsError, fn -> Participants.get_guardian!(guardian.id) end
    end

    test "change_guardian/1 returns a guardian changeset" do
      guardian = guardian_fixture()
      assert %Ecto.Changeset{} = Participants.change_guardian(guardian)
    end
  end
end
