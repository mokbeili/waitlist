defmodule WaitlistWeb.GuardianController do
  use WaitlistWeb, :controller

  alias Waitlist.Participants
  alias Waitlist.Participants.Guardian
  alias Waitlist.Addresses

  def index(conn, _params) do
    guardians = Participants.list_guardians()
    render(conn, "index.html", guardians: guardians)
  end

  def new(conn, _params) do
    changeset = Participants.change_guardian(%Guardian{})
    render(conn, "new.html", changeset: changeset)
  end

  def new_participant(conn, _params) do
    changeset = Participants.change_participant(%Participants.Participants.Participant{})
    render(conn, "new-participant.html", changeset: changeset, addresses: Addresses.list_addresses(conn.assigns.current_user.id))
  end

  def create_participant(conn, %{"participant" => participant_params}) do
    case Participants.create_participant(participant_params, List.first(conn.assigns.addresses).id, conn.assigns.current_user.id) do
      {:ok, participant} ->
        conn
        |> put_flash(:info, "Participant created successfully.")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    guardian = Participants.get_guardian!(id)
    render(conn, "show.html", guardian: guardian)
  end

  def edit(conn, %{"id" => id}) do
    guardian = Participants.get_guardian!(id)
    changeset = Participants.change_guardian(guardian)
    render(conn, "edit.html", guardian: guardian, changeset: changeset)
  end

  def update(conn, %{"id" => id, "guardian" => guardian_params}) do
    guardian = Participants.get_guardian!(id)

    case Participants.update_guardian(guardian, guardian_params) do
      {:ok, guardian} ->
        conn
        |> put_flash(:info, "Guardian updated successfully.")
        |> redirect(to: Routes.guardian_path(conn, :show, guardian))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", guardian: guardian, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    guardian = Participants.get_guardian!(id)
    {:ok, _guardian} = Participants.delete_guardian(guardian)

    conn
    |> put_flash(:info, "Guardian deleted successfully.")
    |> redirect(to: Routes.guardian_path(conn, :index))
  end
end
