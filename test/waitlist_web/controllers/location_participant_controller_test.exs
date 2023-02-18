defmodule WaitlistWeb.LocationParticipantControllerTest do
  use WaitlistWeb.ConnCase

  import Waitlist.LocationParticipantsFixtures

  @create_attrs %{added_at: 42, type: :waitlist}
  @update_attrs %{added_at: 43, type: :active}
  @invalid_attrs %{added_at: nil, type: nil}

  describe "index" do
    test "lists all location_participants", %{conn: conn} do
      conn = get(conn, Routes.location_participant_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Location participants"
    end
  end

  describe "new location_participant" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.location_participant_path(conn, :new))
      assert html_response(conn, 200) =~ "New Location participant"
    end
  end

  describe "create location_participant" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.location_participant_path(conn, :create), location_participant: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.location_participant_path(conn, :show, id)

      conn = get(conn, Routes.location_participant_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Location participant"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.location_participant_path(conn, :create), location_participant: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Location participant"
    end
  end

  describe "edit location_participant" do
    setup [:create_location_participant]

    test "renders form for editing chosen location_participant", %{conn: conn, location_participant: location_participant} do
      conn = get(conn, Routes.location_participant_path(conn, :edit, location_participant))
      assert html_response(conn, 200) =~ "Edit Location participant"
    end
  end

  describe "update location_participant" do
    setup [:create_location_participant]

    test "redirects when data is valid", %{conn: conn, location_participant: location_participant} do
      conn = put(conn, Routes.location_participant_path(conn, :update, location_participant), location_participant: @update_attrs)
      assert redirected_to(conn) == Routes.location_participant_path(conn, :show, location_participant)

      conn = get(conn, Routes.location_participant_path(conn, :show, location_participant))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, location_participant: location_participant} do
      conn = put(conn, Routes.location_participant_path(conn, :update, location_participant), location_participant: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Location participant"
    end
  end

  describe "delete location_participant" do
    setup [:create_location_participant]

    test "deletes chosen location_participant", %{conn: conn, location_participant: location_participant} do
      conn = delete(conn, Routes.location_participant_path(conn, :delete, location_participant))
      assert redirected_to(conn) == Routes.location_participant_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.location_participant_path(conn, :show, location_participant))
      end
    end
  end

  defp create_location_participant(_) do
    location_participant = location_participant_fixture()
    %{location_participant: location_participant}
  end
end
