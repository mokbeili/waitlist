defmodule WaitlistWeb.UserRegistrationController do
  use WaitlistWeb, :controller

  alias Waitlist.Accounts
  alias Waitlist.Accounts.User
  alias WaitlistWeb.UserAuth

  alias Waitlist.Participants
  alias Waitlist.Participants.Guardian

  alias WaitlistWeb.Router.Helpers, as: Routes

  def new(conn, _params) do
    changeset = Accounts.change_user_registration(%User{})
    guardianChangeset = Participants.change_guardian(%Guardian{})
    render(conn, "new.html", changeset: changeset, guardianChangeset: guardianChangeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.register_user(user_params) do
      {:ok, user} ->
        {:ok, _} =
          Accounts.deliver_user_confirmation_instructions(
            user,
            &Routes.user_confirmation_url(conn, :edit, &1)
          )

        conn
        |> put_flash(:info, "User created successfully.")
        |> put_session(:user_return_to, Routes.address_path(conn, :new))
        |> UserAuth.log_in_user(user)

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
