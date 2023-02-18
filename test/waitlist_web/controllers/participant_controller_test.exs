defmodule WaitlistWeb.ParticipantControllerTest do
  use WaitlistWeb.ConnCase

  import Waitlist.Participants.ParticipantsFixtures

  @create_attrs %{date_of_birth: ~D[2023-02-17], first_name: "some first_name", last_name: "some last_name", middle_name: "some middle_name"}
  @update_attrs %{date_of_birth: ~D[2023-02-18], first_name: "some updated first_name", last_name: "some updated last_name", middle_name: "some updated middle_name"}
  @invalid_attrs %{date_of_birth: nil, first_name: nil, last_name: nil, middle_name: nil}

  describe "index" do
    test "lists all participants", %{conn: conn} do
      conn = get(conn, Routes.participant_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Participants"
    end
  end

  describe "new participant" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.participant_path(conn, :new))
      assert html_response(conn, 200) =~ "New Participant"
    end
  end

  describe "create participant" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.participant_path(conn, :create), participant: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.participant_path(conn, :show, id)

      conn = get(conn, Routes.participant_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Participant"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.participant_path(conn, :create), participant: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Participant"
    end
  end

  describe "edit participant" do
    setup [:create_participant]

    test "renders form for editing chosen participant", %{conn: conn, participant: participant} do
      conn = get(conn, Routes.participant_path(conn, :edit, participant))
      assert html_response(conn, 200) =~ "Edit Participant"
    end
  end

  describe "update participant" do
    setup [:create_participant]

    test "redirects when data is valid", %{conn: conn, participant: participant} do
      conn = put(conn, Routes.participant_path(conn, :update, participant), participant: @update_attrs)
      assert redirected_to(conn) == Routes.participant_path(conn, :show, participant)

      conn = get(conn, Routes.participant_path(conn, :show, participant))
      assert html_response(conn, 200) =~ "some updated first_name"
    end

    test "renders errors when data is invalid", %{conn: conn, participant: participant} do
      conn = put(conn, Routes.participant_path(conn, :update, participant), participant: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Participant"
    end
  end

  describe "delete participant" do
    setup [:create_participant]

    test "deletes chosen participant", %{conn: conn, participant: participant} do
      conn = delete(conn, Routes.participant_path(conn, :delete, participant))
      assert redirected_to(conn) == Routes.participant_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.participant_path(conn, :show, participant))
      end
    end
  end

  defp create_participant(_) do
    participant = participant_fixture()
    %{participant: participant}
  end
end
