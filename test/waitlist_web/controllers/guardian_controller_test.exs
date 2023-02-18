defmodule WaitlistWeb.GuardianControllerTest do
  use WaitlistWeb.ConnCase

  import Waitlist.ParticipantsFixtures

  @create_attrs %{date_of_birth: ~D[2023-02-17], first_name: "some first_name", last_name: "some last_name", middle_name: "some middle_name"}
  @update_attrs %{date_of_birth: ~D[2023-02-18], first_name: "some updated first_name", last_name: "some updated last_name", middle_name: "some updated middle_name"}
  @invalid_attrs %{date_of_birth: nil, first_name: nil, last_name: nil, middle_name: nil}

  describe "index" do
    test "lists all guardians", %{conn: conn} do
      conn = get(conn, Routes.guardian_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Guardians"
    end
  end

  describe "new guardian" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.guardian_path(conn, :new))
      assert html_response(conn, 200) =~ "New Guardian"
    end
  end

  describe "create guardian" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.guardian_path(conn, :create), guardian: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.guardian_path(conn, :show, id)

      conn = get(conn, Routes.guardian_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Guardian"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.guardian_path(conn, :create), guardian: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Guardian"
    end
  end

  describe "edit guardian" do
    setup [:create_guardian]

    test "renders form for editing chosen guardian", %{conn: conn, guardian: guardian} do
      conn = get(conn, Routes.guardian_path(conn, :edit, guardian))
      assert html_response(conn, 200) =~ "Edit Guardian"
    end
  end

  describe "update guardian" do
    setup [:create_guardian]

    test "redirects when data is valid", %{conn: conn, guardian: guardian} do
      conn = put(conn, Routes.guardian_path(conn, :update, guardian), guardian: @update_attrs)
      assert redirected_to(conn) == Routes.guardian_path(conn, :show, guardian)

      conn = get(conn, Routes.guardian_path(conn, :show, guardian))
      assert html_response(conn, 200) =~ "some updated first_name"
    end

    test "renders errors when data is invalid", %{conn: conn, guardian: guardian} do
      conn = put(conn, Routes.guardian_path(conn, :update, guardian), guardian: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Guardian"
    end
  end

  describe "delete guardian" do
    setup [:create_guardian]

    test "deletes chosen guardian", %{conn: conn, guardian: guardian} do
      conn = delete(conn, Routes.guardian_path(conn, :delete, guardian))
      assert redirected_to(conn) == Routes.guardian_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.guardian_path(conn, :show, guardian))
      end
    end
  end

  defp create_guardian(_) do
    guardian = guardian_fixture()
    %{guardian: guardian}
  end
end
