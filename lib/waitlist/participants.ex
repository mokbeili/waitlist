defmodule Waitlist.Participants do
  @moduledoc """
  The Participants context.
  """
  import Ecto.Query, warn: false
  alias Waitlist.Repo

  alias Waitlist.Participants.Guardian
  alias Waitlist.Participants.Participants.Participant

  @doc """
  Returns the list of guardians.

  ## Examples

      iex> list_guardians()
      [%Guardian{}, ...]

  """
  def list_guardians do
    Repo.all(Guardian)
  end

  @doc """
  Gets a single guardian.

  Raises `Ecto.NoResultsError` if the Guardian does not exist.

  ## Examples

      iex> get_guardian!(123)
      %Guardian{}

      iex> get_guardian!(456)
      ** (Ecto.NoResultsError)

  """
  def get_guardian!(id), do: Repo.get!(Guardian, id)

  def get_guardians_by_user(id) do
    Repo.all(from g in Guardian, where: g.user_id == ^id)
  end

  @doc """
  Creates a guardian.

  ## Examples

      iex> create_guardian(%{field: value})
      {:ok, %Guardian{}}

      iex> create_guardian(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_guardian(attrs \\ %{}, addressId, userId) do
    %Guardian{user_id: userId, address_id: addressId}
    |> Guardian.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a guardian.

  ## Examples

      iex> update_guardian(guardian, %{field: new_value})
      {:ok, %Guardian{}}

      iex> update_guardian(guardian, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_guardian(%Guardian{} = guardian, attrs) do
    guardian
    |> Guardian.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a guardian.

  ## Examples

      iex> delete_guardian(guardian)
      {:ok, %Guardian{}}

      iex> delete_guardian(guardian)
      {:error, %Ecto.Changeset{}}

  """
  def delete_guardian(%Guardian{} = guardian) do
    Repo.delete(guardian)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking guardian changes.

  ## Examples

      iex> change_guardian(guardian)
      %Ecto.Changeset{data: %Guardian{}}

  """
  def change_guardian(%Guardian{} = guardian, attrs \\ %{}) do
    Guardian.changeset(guardian, attrs)
  end


  @doc """
  Returns the list of participants.

  ## Examples

      iex> list_participants()
      [%Participant{}, ...]

  """
  def list_participants do
    Repo.all(Participant)
  end

  @doc """
  Gets a single participant.

  Raises `Ecto.NoResultsError` if the Participant does not exist.

  ## Examples

      iex> get_participant!(123)
      %Participant{}

      iex> get_participant!(456)
      ** (Ecto.NoResultsError)

  """
  def get_participant!(id), do: Repo.get!(Participant, id)

  @doc """
  Creates a participant.

  ## Examples

      iex> create_participant(%{field: value})
      {:ok, %Participant{}}

      iex> create_participant(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_participant(attrs \\ %{}, addressId, guardianId) do
    %Participant{guardian_id: guardianId, address_id: addressId}
    |> Participant.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a participant.

  ## Examples

      iex> update_participant(participant, %{field: new_value})
      {:ok, %Participant{}}

      iex> update_participant(participant, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_participant(%Participant{} = participant, attrs) do
    participant
    |> Participant.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a participant.

  ## Examples

      iex> delete_participant(participant)
      {:ok, %Participant{}}

      iex> delete_participant(participant)
      {:error, %Ecto.Changeset{}}

  """
  def delete_participant(%Participant{} = participant) do
    Repo.delete(participant)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking participant changes.

  ## Examples

      iex> change_participant(participant)
      %Ecto.Changeset{data: %Participant{}}

  """
  def change_participant(%Participant{} = participant, attrs \\ %{}) do
    Participant.changeset(participant, attrs)
  end

end
