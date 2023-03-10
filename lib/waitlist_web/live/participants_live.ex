defmodule WaitlistWeb.ParticipantsLive do
  import Logger
  use WaitlistWeb, :live_view
  alias Waitlist.Participants.Guardian
  alias Waitlist.Participants
  alias Waitlist.Participants.Participants.Participant
  alias Waitlist.Addresses

  alias Waitlist.Accounts

  def render(assigns) do
    ~H"""
      <div class="h-10 w-32">
        <.form let = {f} for={@participant_changeset} phx-change="validate_participant" phx-submit="save-participant">
            <%= label f, :first_name %>
            <%= text_input f, :first_name %>
            <%= error_tag f, :first_name %>

            <%= label f, :last_name %>
            <%= text_input f, :last_name %>
            <%= error_tag f, :last_name %>

            <%= label f, :middle_name %>
            <%= text_input f, :middle_name %>
            <%= error_tag f, :middle_name %>

            <%= label f, :date_of_birth %>
            <%= date_select f, :date_of_birth %>
            <%= error_tag f, :date_of_birth %>

            <button type="submit" phx-disable-with="Saving...">Save</button>
          </.form>
      </div>
    """
  end

  def mount(_params, %{"user_token" => user_token} = _session, socket) do
      current_user = Accounts.get_user_by_session_token(user_token)
      socket = assign(socket,
                    participant_changeset: Participants.change_participant(%Participant{}),
                    current_guardians: Participants.get_guardians_by_user(current_user.id))
    {:ok, socket}
  end


  def handle_event("validate_participant", %{"participant" => params}, socket) do
    changeset =
      %Participant{}
      |> Participant.changeset(params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, participant_changeset: changeset)}
  end

  def handle_event("save-participant", %{"participant" => participant_params}, socket) do
    case Participants.create_participant(participant_params, List.first(socket.assigns.current_guardians).address_id, List.first(socket.assigns.current_guardians).id) do
      {:ok} ->
        socket
        |> put_flash(:info, "Participant created successfully.")

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, participant_changeset: changeset)}
    end
  end
end
