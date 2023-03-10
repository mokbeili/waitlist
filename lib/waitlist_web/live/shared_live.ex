defmodule WaitlistWeb.SharedLive do
  import Logger
  use WaitlistWeb, :live_view
  alias Waitlist.ParticipantsFixtures
  alias Waitlist.Participants.Guardian
  alias  Waitlist.Participants

  alias Waitlist.Providers
  alias Waitlist.Providers.Provider
  alias Waitlist.Accounts

  alias Waitlist.Addresses

  def render(assigns) do
    ~H"""
      <div class="h-10 w-32">
        <%= if @type === nil do %>
          <div class="toggle">
            <button phx-click="set-type" value="guardian" type="button">I'm a Parent / Guardian</button>
            <button phx-click="set-type" value="provider" type="button">I Represent a Daycare</button>
          </div>
        <% end %>
        <%= if @type === "guardian" do %>
        <.form let = {f} for={@guardian_changeset} phx-change="validate_guardian" phx-submit="save-guardian">
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
        <% end %>
        <%= if @type === "provider" do %>
          <p>Provider</p>
        <% end %>
      </div>
    """
  end

  def mount(_params, %{"user_token" => user_token} = _session, socket) do
      socket = assign(socket,
                    guardian_changeset: Participants.change_guardian(%Guardian{}),
                    provider_changeset: Providers.change_provider(%Provider{}),
                    trigger_submit_guardian: false,
                    trigger_submit_provider: false,
                    type: nil,
                    current_user: Accounts.get_user_by_session_token(user_token))
    {:ok, socket}
  end

  @impl true
  def handle_event("set-type",  %{"value" => value}, socket) do
    socket = assign(socket, type: value)
    {:noreply, socket}
  end

  def handle_event("validate_guardian", %{"guardian" => params}, socket) do
    changeset =
      %Guardian{}
      |> Guardian.changeset(params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, guardian_changeset: changeset)}
  end

  def handle_event("save-guardian", %{"guardian" => guardian_params}, socket) do
    addresses = Addresses.list_addresses(socket.assigns.current_user.id)
    case Participants.create_guardian(guardian_params, List.first(addresses).id, socket.assigns.current_user.id) do
      {:ok} ->
        socket
        |> put_flash(:info, "Guardian created successfully.")

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, guardian_changeset: changeset)}
    end
  end

end
