defmodule Waitlist.LocationParticipants do
  @moduledoc """
  The LocationParticipants context.
  """

  import Ecto.Query, warn: false
  alias Waitlist.Repo

  alias Waitlist.LocationParticipants.LocationParticipant

  @doc """
  Returns the list of location_participants.

  ## Examples

      iex> list_location_participants()
      [%LocationParticipant{}, ...]

  """
  def list_location_participants do
    Repo.all(LocationParticipant)
  end

  @doc """
  Gets a single location_participant.

  Raises `Ecto.NoResultsError` if the Location participant does not exist.

  ## Examples

      iex> get_location_participant!(123)
      %LocationParticipant{}

      iex> get_location_participant!(456)
      ** (Ecto.NoResultsError)

  """
  def get_location_participant!(id), do: Repo.get!(LocationParticipant, id)

  @doc """
  Creates a location_participant.

  ## Examples

      iex> create_location_participant(%{field: value})
      {:ok, %LocationParticipant{}}

      iex> create_location_participant(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_location_participant(attrs \\ %{}) do
    %LocationParticipant{}
    |> LocationParticipant.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a location_participant.

  ## Examples

      iex> update_location_participant(location_participant, %{field: new_value})
      {:ok, %LocationParticipant{}}

      iex> update_location_participant(location_participant, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_location_participant(%LocationParticipant{} = location_participant, attrs) do
    location_participant
    |> LocationParticipant.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a location_participant.

  ## Examples

      iex> delete_location_participant(location_participant)
      {:ok, %LocationParticipant{}}

      iex> delete_location_participant(location_participant)
      {:error, %Ecto.Changeset{}}

  """
  def delete_location_participant(%LocationParticipant{} = location_participant) do
    Repo.delete(location_participant)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking location_participant changes.

  ## Examples

      iex> change_location_participant(location_participant)
      %Ecto.Changeset{data: %LocationParticipant{}}

  """
  def change_location_participant(%LocationParticipant{} = location_participant, attrs \\ %{}) do
    LocationParticipant.changeset(location_participant, attrs)
  end
end
