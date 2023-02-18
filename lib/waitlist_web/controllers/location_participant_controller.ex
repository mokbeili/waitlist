defmodule WaitlistWeb.LocationParticipantController do
  use WaitlistWeb, :controller

  alias Waitlist.LocationParticipants
  alias Waitlist.LocationParticipants.LocationParticipant

  def index(conn, _params) do
    location_participants = LocationParticipants.list_location_participants()
    render(conn, "index.html", location_participants: location_participants)
  end

  def new(conn, _params) do
    changeset = LocationParticipants.change_location_participant(%LocationParticipant{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"location_participant" => location_participant_params}) do
    case LocationParticipants.create_location_participant(location_participant_params) do
      {:ok, location_participant} ->
        conn
        |> put_flash(:info, "Location participant created successfully.")
        |> redirect(to: Routes.location_participant_path(conn, :show, location_participant))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    location_participant = LocationParticipants.get_location_participant!(id)
    render(conn, "show.html", location_participant: location_participant)
  end

  def edit(conn, %{"id" => id}) do
    location_participant = LocationParticipants.get_location_participant!(id)
    changeset = LocationParticipants.change_location_participant(location_participant)
    render(conn, "edit.html", location_participant: location_participant, changeset: changeset)
  end

  def update(conn, %{"id" => id, "location_participant" => location_participant_params}) do
    location_participant = LocationParticipants.get_location_participant!(id)

    case LocationParticipants.update_location_participant(location_participant, location_participant_params) do
      {:ok, location_participant} ->
        conn
        |> put_flash(:info, "Location participant updated successfully.")
        |> redirect(to: Routes.location_participant_path(conn, :show, location_participant))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", location_participant: location_participant, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    location_participant = LocationParticipants.get_location_participant!(id)
    {:ok, _location_participant} = LocationParticipants.delete_location_participant(location_participant)

    conn
    |> put_flash(:info, "Location participant deleted successfully.")
    |> redirect(to: Routes.location_participant_path(conn, :index))
  end
end
