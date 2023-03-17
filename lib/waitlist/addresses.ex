defmodule Waitlist.Addresses do
  @moduledoc """
  The Addresses context.
  """

  import Ecto.Query, warn: false
  import Logger
  alias Waitlist.Repo

  alias Waitlist.Addresses.Address

  @doc """
  Returns the list of addresses.

  ## Examples

      iex> list_addresses()
      [%Address{}, ...]

  """

  def list_addresses(userId) do
    Repo.all(from a in Address, where: a.user_id == ^userId, select: a)
  end

  @doc """
  Gets a single address.

  Raises `Ecto.NoResultsError` if the Address does not exist.

  ## Examples

      iex> get_address!(123)
      %Address{}

      iex> get_address!(456)
      ** (Ecto.NoResultsError)

  """
  def get_address!(id), do: Repo.get!(Address, id)

  @doc """
  Creates a address.

  ## Examples

      iex> create_address(%{field: value})
      {:ok, %Address{}}

      iex> create_address(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_address(attrs \\ %{}, userId) do
    {:ok, results } = geocode(attrs)
    locationData = List.first(Map.get(results, "results"))["geometry"]["location"]
    %Address{user_id: userId, latitude: locationData["lat"], longitude: locationData["lng"]}
    |> Address.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a address.

  ## Examples

      iex> update_address(address, %{field: new_value})
      {:ok, %Address{}}

      iex> update_address(address, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_address(%Address{} = address, attrs) do
    address
    |> Address.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a address.

  ## Examples

      iex> delete_address(address)
      {:ok, %Address{}}

      iex> delete_address(address)
      {:error, %Ecto.Changeset{}}

  """
  def delete_address(%Address{} = address) do
    Repo.delete(address)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking address changes.

  ## Examples

      iex> change_address(address)
      %Ecto.Changeset{data: %Address{}}

  """
  def change_address(%Address{} = address, attrs \\ %{}) do
    Address.changeset(address, attrs)
  end

  @spec geocode(map) ::
          {:error, binary | HTTPoison.Error.t()}
          | {:ok, map}
          | {:error, binary | HTTPoison.Error.t(), binary}
  def geocode(address_params \\ %{}) do
    GoogleMaps.geocode(Enum.join([
      Map.get(address_params, "lineOne"),
      Map.get(address_params, "lineTwo"),
      Map.get(address_params, "city"),
      Map.get(address_params, "province"),
      Map.get(address_params, "postalCode")],
      key: "")
  end
end
